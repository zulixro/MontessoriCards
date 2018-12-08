class CardsController < ApplicationController
  before_action :get_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
  end

  def create
    card = Card.new(card_params)
    if card.save!
      flash[:notice] = "Your new Montessori Card is here!"
      redirect_to card_path(card)
    else
      flash[:error] = "Ups. Something went wrong.."
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      flash[:notice] = "Your Montessori Card has been updated."
      redirect_to card_path(card)
    else
      flash[:error] = "Ups. Something went wrong.."
      render :edit
    end
  end

  def destroy
    if @card.destroy
      flash[:notice] = "Your Montessori Card has been deleted."
      redirect_to cards_path
    else
      flash[:error] = "Ups. Something went wrong.."
      render :show
    end
  end

  private

  def get_card
    @card = Card.find(params[:id])
  end
end
