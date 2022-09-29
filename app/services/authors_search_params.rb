class AuthorsSearchParams
  include ActiveModel::Model

  attr_accessor :name_like, :reviews_over, :reviews_under, :review_id, :recipes_over, :recipes_under, :recipe_id

  validates :reviews_over, numericality: {greater_than: 0, only_integer: true, allow_nil: true}
  validates :reviews_under, numericality: {greater_than: 0, only_integer: true, allow_nil: true}
  validates :recipes_over, numericality: {greater_than: 0, only_integer: true, allow_nil: true}
  validates :recipes_under, numericality: {greater_than: 0, only_integer: true, allow_nil: true}

  def initialize(args)
    @name_like = args["name_like"]
    @reviews_over = args["reviews_over"]
    @reviews_under = args["reviews_under"]
    @review_id = args["review_id"]
    @recipes_over = args["recipes_over"]
    @recipes_under = args["recipes_under"]
    @recipe_id = args["recipe_id"]
  end

  def review_ids
    @review_ids ||= review_id&.split(",")&.map { |id| id.strip.to_i } || []
  end

  def recipe_ids
    @recipe_ids ||= recipe_id&.split(",")&.map { |id| id.strip.to_i } || []
  end

end