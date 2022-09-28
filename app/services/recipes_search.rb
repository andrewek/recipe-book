class RecipesSearch
  attr_accessor :params

  # name_like
  # duration_under
  # duration_over
  # author_id
  # category_id
  # tagged_as

  def initialize(params)
    @params = RecipesSearchParams.new(params)
  end

  def call
    query = Recipe
    raise ArgumentError unless params.valid?

    if params.name_like
      query = query.name_is_like(params.name_like)
    end

    if params.duration_under
      query = query.makeable_in_at_most(params.duration_under)
    end

    if params.duration_over
      query = query.makeable_in_at_least(params.duration_over)
    end

    if params.author_ids.any?
      query = query.where(author_id: params.author_ids)
    end

    query.includes(:tags, :author, :category).all
  end
end