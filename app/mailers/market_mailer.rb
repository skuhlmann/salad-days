class MarketMailer < ActionMailer::Base
  default from: "no-reply@saladdays.xyz"

  def contact_email(listing, contact_email)
    @listing = listing
    @contact_email = contact_email
    mail(to: @listing.market.email, subject: "Salad Days Listing Inquiry")
  end

  def new_listing_email(user, listing)
    @listing = listing
    @user = user
    mail(to: @user.market.email, subject: "Salad Days #{@listing.market.name} has added some fresh food")
  end

end
