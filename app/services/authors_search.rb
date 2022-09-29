class AuthorsSearch
  attr_accessor :params

  # name_like
  # reviews_over
  # reviews_under
  # review_id
  # recipe_id
  # recipes_over
  # recipes_under

  def initialize(params)
    @params = AuthorsSearchParams.new(params)
  end

  def call
    query = Author
    raise ArgumentError unless params.valid?

    if params.name_like
      query = query.search_all_authors(params.name_like)
    end

    if params.review_ids.any?
      query = query.where(reviews: params.review_ids)
    end

    if params.reviews_over
      query = query.joins(:reviews).where("rating >= ?", params.reviews_over).distinct
    end

    if params.reviews_under
      query = query.joins(:reviews).where("rating <= ?", params.reviews_under).distinct
    end

    if params.recipe_ids.any?
      query = query.where(recipes: params.recipe_ids)
    end

    if params.recipes_over
      query = query.joins(:recipes).where("duration_in_minutes >= ?", params.recipes_over).distinct
    end

    if params.recipes_under
      query = query.joins(:recipes).where("duration_in_minutes <= ?", params.recipes_under).distinct
    end

    query.all
  end
end