require "rails_helper"

RSpec.describe Resolvers::Kitchens::Get do
  let(:query_string) do
    <<~QUERY
      query($id: ID!) { kitchen(id: $id) {
        name id
      }}
    QUERY
  end

  it "gets a kitchen" do
    kitchen = create(:kitchen)

    result = RecipeBookSchema.execute(
      query_string,
      variables: {id: kitchen.id},
      context: {}
    )

    kitchen_data = result.to_h.dig("data", "kitchen")
    
    expect(kitchen_data["id"]).to eq(kitchen.id.to_s)
    expect(kitchen_data["name"]).to eq(kitchen.name)
  end

  it "raises when not found" do
    expect { RecipeBookSchema.execute(
      query_string,
      variables: {id: 0},
      context: {}
    ) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end