class MarketMailer < ActionMailer::Base
  default from: "no-reply@saladdays.xyz"

  def contact_email(listing, contact_email)
    @listing = listing
    @contact_email = contact_email
    mail(to: @listing.market.email, subject: "Salad Days Listing Inquiry")
  end
end
