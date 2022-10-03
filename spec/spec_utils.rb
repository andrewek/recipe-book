def exec_graphql(query_string, variables: {}, context: {})
  RecipeBookSchema.execute(
    query_string, 
    variables: variables, 
    context: context
  ).to_h.deep_symbolize_keys
end