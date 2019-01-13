class CardsController < ApplicationController
  before_action :get_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "#{@card.name}",
            :layout =>'pdf.html.erb',
            :template => 'cards/pdf.html.erb',
            :page_size => "A4",
            :disposition => 'attachment'
      end
    end
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
    @categories = Category.all.map { |category| [category.name, category.id]}
  end

  def update
    if @card.update(card_params)
      flash[:notice] = "Your Montessori Card has been updated."
      redirect_to card_path(@card)
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

  def card_urls
    begin
      card_urls = WikimediaConnector.new(params[:card_name]).get_urls
      render json: { urls: card_urls }
    rescue Wikimedia::Error
      render json: { error: "No image found" }, status: :unprocessable
    end
  end

  private

  def get_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:name, :category_id, :url)
  end
end
