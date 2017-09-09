class OffersFascade
  attr_accessor :offer, :offers, :current_user_offers

  def initialize(params, current_user = nil)
    @offer = Offer.find_by(id: params[:id]) if params[:id]
    @offers = Offer.all
    @current_user_offers = current_user.offers if current_user
  end

  def search(params)
    if params[:position]
      @offers = @offers.select { |c| c.position.downcase.include? params[:position].downcase }
    elsif params[:salary]
      @offers = @offers.select { |c| c.salary.downcase.include? params[:salary].downcase  }
    elsif params[:type_of_contract]
      @offers = @offers.select { |c| c.type_of_contract.downcase.include? params[:type_of_contract].downcase  }
    end
  end

  def applicants
    @offer.applicants.map(&:customer)
  end

  def new_offer
    Offer.new
  end

  def update
    Applicant.create(offer: @offer, customer: @current_user)
  end

  def company_title
    @offer.company.title
  end

  def company_description
    @offer.company.description
  end

  def company_offers
    @offer.company.offers
  end

  def not_currently_opened(offer)
    @offer != offer
  end
end