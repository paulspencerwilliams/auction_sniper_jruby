class ApplicationRunner

  SNIPER_ID = 'sniper'
  SNIPER_PASSWORD = 'sniper'


  def start_bidding_in(auction)
    Main.main(SNIPER_ID, SNIPER_PASSWORD, auction.item_id())
    @driver = AuctionSniperDriver.new(1000)
    @driver.shows_sniper_status(Main::STATUS_JOINING)
  end

  def announce_closed
  end

  def shows_sniper_has_lost_auction
    @driver.shows_sniper_status(STATUS_LOST)
  end

  def stop
    @driver.dispose unless @driver.nil?
  end
end
