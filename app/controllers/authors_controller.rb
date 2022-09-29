class AuthorsController < ApplicationController
  before_action :find_author, only: [:show, :update, :destroy]

  def index
    @authors = AuthorsSearch.new(params.to_unsafe_h).call
    render json: @authors
  end

  def show
    if @author
      render json: @author
    else
      render json: { errors: ["That author does not exist."] }, status: :not_found
    end
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render json: { data: @author }, status: :ok
    else
      render json: { errors: @author.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @author && @author.update(author_params)
      render json: { data: @author }, status: :ok
    else
      render json: { errors: ["Cannot update author."] }, status: :bad_request
    end
  end

  def destroy
    if @author && @author.destroy
      render json: { data: @author, message: "Deletion successful." }, status: :ok
    else
      render json: { errors: ["Cannot delete, does not exist."] }, status: :bad_request
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end

  def find_author
    id = params[:id]

    @author = Author.find_by(id: id)
  end
end
