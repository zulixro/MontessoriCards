class CategoriesController < ApplicationController
  before_action :get_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @cards = @category.cards
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save!
      flash[:notice] = "Your new Montessori Set is here! Add some cards."
      redirect_to category_path(category)
    else
      flash[:error] = "Ups. Something went wrong.."
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Your Montessori Set has been updated."
      redirect_to category_path(@category)
    else
      flash[:error] = "Ups. Something went wrong.."
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Your Montessori Set has been deleted."
      redirect_to categories_path
    else
      flash[:error] = "Ups. Something went wrong.."
      render :show
    end
  end

  private

  def get_category
    @category = Category.includes(:cards).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
