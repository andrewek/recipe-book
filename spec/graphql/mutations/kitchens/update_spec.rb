require "rails_helper"

RSpec.describe Mutations::Kitchens::Update do
  let(:kitchen) { create(:kitchen) }
  let(:query_string) do
    <<~QUERY
      mutation($id: ID!, $name: String, $location: String, $value: Int) {
        updateKitchen(input: {
          id: $id
          params: {
            name: $name
            location: $location
            value: $value
          }
        }) {
          kitchen {
            name id location author { name id }
          }
        }
      }
    QUERY
  end

    it "updates an existing kitchen" do
      result = exec_graphql(
        query_string,
        variables: {
          id: kitchen.id,
          name: "The Bad Place"
        }
      )
      
      expect(result.dig(:data, :updateKitchen, :kitchen, :name)).to eq("The Bad Place")
    end

    it "returns an error if the kitchen doesn't exist" do
      result = exec_graphql(
        query_string,
        variables: {
          id: 0,
          name: "The Bad Place"
        }
      )

      puts result.inspect
    end
end