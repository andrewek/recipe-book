require 'rails_helper'

RSpec.describe "Authors", type: :request do
  let(:author) { Author.create!(name: "Handsome Bob") }
  
  describe "GET /authors" do
    it "lists all recipes as json" do
      author

      get "/authors"
      expect(response.content_type).to include("application/json")
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body.length).to eq(1)
      item = body.first

      expect(item[:name]).to eq(author.name)
    end
  end

  describe "GET /authors/:id" do
    it "fetches an author" do
      id = author.id
      get "/authors/#{id}"

      expect(response.status).to eq(200)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:name]).to eq(author.name)
    end

    it "returns 404" do
      get "/authors/0"
      expect(response.status).to eq(404)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to eq({ errors: ["That author does not exist."] })
    end
  end

  describe "POST /authors" do
    it "creates with valid params" do
      post "/authors", params: {
        author: {
          name: "Chicken Little",
          age: 18
        }
      }

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(body[:name]).to eq("Chicken Little")
      expect(body[:age]).to eq(nil)
    end

    it "fails with invalid params" do
      pre_count = Author.count

      post "/authors", params: { author: { name: "" } }

      post_count = Author.count
      expect(pre_count).to eq(post_count)

      body = JSON.parse(response.body, symbolize_names: true)
      errors = body[:errors]

      expect(errors).to include("Name is too short (minimum is 2 characters)")
    end
  end

  describe "PATCH /authors/:id" do
    it "does not update nonexistent id" do
      id = 0

      put "/authors/#{id}", params: { author: { name: "Tom Cruise" } }

      expect(response.status).to eq(400)
    end

    it "updates valid params" do
      id = author.id

      put "/authors/#{id}", params: {
        author: {
          name: "Tom Cruise",
          age: "50"
        }
      }

      body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(200)
      expect(body[:name]).to eq("Tom Cruise")
      expect(body[:age]).to eq(nil)
    end
  end

  describe "DESTROY /authors/:id" do
    it "deletes an existing author" do
      id = author.id
      pre_count = Author.count

      delete "/authors/#{id}"

      post_count = Author.count
      expect(pre_count).to_not eq(post_count)

      body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(200)
      expect(body[:name]).to eq(author.name)
    end
  end

end
