class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :current_author

  def created(record)
    render_json(record, status: :created)
  end

  def current_author
#    @current_author ||= assign_current_author()
    # FIXME: This needs to be addressed for real later
    @current_author = Author.first
  end

  def deleted(record)
    render_json(record, status: :ok)
  end

  def ok(record)
    render_json(record, status: :ok)
  end

  private

  def assign_current_author()
    begin
      b64_string = request.headers["HTTP_AUTHORIZATION"].sub("Basic ", "")
      user_string, password = Base64.decode64(b64_string).split(":")

      id = user_string.sub("author-", "").strip

      Author.find(id)
    rescue
      render json: {
        message: "The provided credentials are incorrect. Please check your credentials."
      }, status: 401
    end
  end

  def render_json(record, status: :ok)

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
