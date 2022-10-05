require "rails_helper"

RSpec.describe Mutations::Kitchens::Create do
  let(:author) { create(:author) }
  let(:query_string) do
    <<~QUERY
      mutation($name: String!, $authorId: Int!) { createKitchen(input: { params: {
        name: $name,
        authorId: $authorId,
      }}) {
        kitchen { name id }
      }}
    QUERY
  end

  it "creates" do
    result = exec_graphql(
      query_string,
      variables: {
        name: "Bobby's Burger Palace",
        value: 500_000,
        authorId: author.id
      }
    )

    id = result.dig(:data, :createKitchen, :kitchen, :id)

    kitchen = Kitchen.find(id)

    expect(kitchen.value).to eq(500_000)
    expect(kitchen.name).to eq("Bobby's Burger Palace")
    end
  end