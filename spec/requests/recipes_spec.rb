require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let(:author) { Author.create!(name: "Jane Austen") }
  let(:category) { Category.create!(name: "Tasty Things") }
  let(:recipe) do 
    Recipe.create!(
      name: "some foooood", 
      author: author, 
      category: category, 
      duration_in_minutes: 90
    )
  end

  describe "GET /recipes/:id" do
    it "fetches a recipe" do
      id = recipe.id
      get "/recipes/#{id}"

      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:name]).to eq(recipe.name)
      expect(data[:duration_in_minutes]).to eq(recipe.duration_in_minutes)
      expect(data[:category]).to eq(category.name)
      expect(data[:author]).to eq(author.name)
    end

    it "returns 404" do
      get "/recipes/0"
      expect(response.status).to eq(404)
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to eq({errors: ["That recipe does not exist"]})
    end
  end

  describe "GET /recipes" do
    it "lists all recipes as json" do
      recipe

      get "/recipes"
      expect(response.content_type).to include("application/json")
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.length).to eq(1)
      item = data.first
      
      expect(item[:name]).to eq(recipe.name)
      expect(item[:duration_in_minutes]).to eq(recipe.duration_in_minutes)
      expect(item[:category]).to eq(category.name)
      expect(item[:author]).to eq(author.name)
    end
  end

  describe "POST /recipes" do
    it "creates with valid params" do
      post "/recipes", params: {
        recipe: {
          name: "Baba Ganoush", 
          author_id: author.id, 
          category_id: category.id, 
          duration_in_minutes: 90
        } 
      }

      expect(response).to be_successful
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:name]).to eq("Baba Ganoush")
      expect(body[:author]).to eq(author.name)
      expect(body[:category]).to eq(category.name)
      expect(body[:duration_in_minutes]).to eq(90)

      id = body[:id]

      expect(Recipe.find(id)).to be_present
    end

    it "fails with invalid params" do
      pre_count = Recipe.count

      post "/recipes", params: {recipe: {name: ""} }

      post_count = Recipe.count
      expect(pre_count).to eq(post_count)

      parsed_body = JSON.parse(response.body, symbolize_names: true)
      errors = parsed_body[:errors]

      expect(errors).to include("Name is too short (minimum is 2 characters)")
    end
  end

  describe "PATCH /recipes/:id" do
    it "does not update nonexistent id" do
      id = 200

      put "/recipes/#{id}", params: {
        recipe: {
          name: "Gourmet Chicken Nuggets", 
          author_id: author.id, 
          category_id: category.id, 
          duration_in_minutes: 240
        } 
      }

      expect(response.status).to eq(404)
    end
    
    it "updates valid params" do
      id = recipe.id
      
      patch "/recipes/#{id}", params: {
        recipe: {
          name: "Gourmet Chicken Nuggets", 
          taste: "good",
          author_id: author.id, 
          category_id: category.id, 
          duration_in_minutes: 240
        } 
      }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(body[:name]).to eq("Gourmet Chicken Nuggets")
      expect(body[:taste]).to eq(nil)
      expect(body[:author]).to eq(author.name)
      expect(body[:category]).to eq(category.name)
      expect(body[:duration_in_minutes]).to eq(240)
    end
  end

  describe "DESTROY /recipes/:id" do
    it "deletes an existing recipe" do
      id = recipe.id
      
      pre_count = Recipe.count

      delete "/recipes/#{id}"

      post_count = Recipe.count

      expect(pre_count).to_not eq(post_count)
      expect(response.status).to eq(200)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:name]).to eq(recipe.name)
      expect(body[:duration_in_minutes]).to eq(recipe.duration_in_minutes)
      expect(body[:category_id]).to eq(recipe.category_id)
      expect(body[:author_id]).to eq(recipe.author_id)
    end
  end
end
