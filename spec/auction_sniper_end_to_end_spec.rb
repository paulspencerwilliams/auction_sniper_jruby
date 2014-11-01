RSpec.describe "AuctionSniper" do
  auction = FakeAuctionServer.new 'item-54321'
  application = ApplicationRunner.new
  it "joins auction until action closes" do
    auction.start_selling_item
    application.start_bidding_in auction
    auction.has_received_join_request_from_snipper
    application.announce_closed
    application.shows_sniper_has_lost_auction
  end

  after(:each) do
    auction.stop
  end

  after(:each) do
    application.stop
  end
end
