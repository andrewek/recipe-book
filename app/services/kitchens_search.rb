class KitchensSearch
  attr_accessor :params

  def initialize(params)
    @params = KitchensSearchParams.new(params)
  end

  def call
    query = Kitchen
    raise ArgumentError unless params.valid?

    if params.name_like
      query = query.name_is_like(params.name_like)
    end

    if params.author_id
      query = query.where(author: params.author_id)
    end

    if params.valued_over
      query = query.valued_more_than(params.valued_over)
    end

    if params.valued_under
      query = query.valued_less_than(params.valued_under)
    end

    query.includes(:author).all
  end
end