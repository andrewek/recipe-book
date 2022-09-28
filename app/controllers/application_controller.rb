class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # Serialize w/ a 200 response
  def ok(record)
    render_json(record, status: :ok)
  end

  def created(record)
    render_json(record, status: :created)
  end

  def deleted(record)
    render json: record, each_serializer: serializer_for(record), message: "Deletion successful.", status: :ok
  end

  private

  def render_json(record, status: :ok)
    puts "#################################"
    puts record.inspect
    puts "##################################"

    # Do we have one element, or many?
    if !record.is_a?(ActiveRecord::Relation)
      render json: record, each_serializer: serializer_for(record), status: status
    elsif record.empty?
      render json: record, status: status
    else
      render json: record, each_serializer: serializer_for(record.first), status: status
    end
  end


  def serializer_for(record)
    "#{record.class.to_s}Serializer".constantize
  end
end
