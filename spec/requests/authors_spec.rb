require 'rails_helper'

RSpec.describe "Authors", type: :request do
  let(:author) { Author.create!(name: "Handsome Bob") }
  
  describe "GET /authors" do
    it "lists all recipes as json" do
      author

      get "/authors"
      expect(response.content_type).to include("application/json")
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.length).to eq(1)
      item = data.first

      expect(item[:name]).to eq(author.name)
    end
  end

  describe "GET /authors/:id" do
    it "fetches an author" do
      id = author.id
      get "/authors/#{id}"

      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:name]).to eq(author.name)
    end

    it "returns 404" do
      get "/authors/0"
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to eq({ errors: ["That author does not exist."] })
    end

    
  end

end
