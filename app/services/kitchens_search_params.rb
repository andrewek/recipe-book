class KitchensSearchParams
  include ActiveModel::Model

  attr_accessor :name_like, :location_like, :valued_over, :valued_under, :author_id
  
  validates :valued_over, numericality: {greater_than: 0, only_integer: true, allow_nil: true}
  validates :valued_under, numericality: {greater_than: 0, only_integer: true, allow_nil: true}

  def initialize(args)
    args = args.with_indifferent_access

    @name_like = args["name_like"]
    @location_like = args["location_like"]
    @valued_over = args["valued_over"]
    @valued_under = args["valued_under"]
    @author_id = args["author_id"]
  end
end