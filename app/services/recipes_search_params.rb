class RecipesSearchParams 
  include ActiveModel::Model

  attr_accessor :name_like, :duration_under, :duration_over, :author_id

  validates :duration_under, numericality: {greater_than: 0, only_integer: true, allow_nil: true}
  validates :duration_over, numericality: {greater_than: 0, only_integer: true, allow_nil: true}

  def initialize(args)
    args = args.with_indifferent_access
    
    @duration_under = args["duration_under"]
    @duration_over = args["duration_over"]
    @name_like = args["name_like"]
    @author_id = args["author_id"]
  end

  def author_ids
    @author_ids ||= 
    if author_id.is_a?(String)
      author_id&.split(",")&.map { |id| id.strip.to_i } || []
    elsif author_id.is_a?(Array)
      author_id
    elsif author_ids.is_a?(Numeric)
      author_id
    else
      []
    end
  end
end