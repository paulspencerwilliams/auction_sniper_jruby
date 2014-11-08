class ApplicationRunner

  SNIPER_ID = 'sniper'
  SNIPER_PASSWORD = 'sniper'


  def start_bidding_in(auction)
    Thread.new do
      Main.main(XMPP_HOSTNAME, SNIPER_ID, SNIPER_PASSWORD, auction.getItemId())
    end
    @driver = AuctionSniperDriver.new(1000)
    @driver.showsSniperStatus(Main::STATUS_JOINING)
  end

  def announce_closed
  end

  def shows_sniper_has_lost_auction
    @driver.showsSniperStatus(STATUS_LOST)
  end

  def stop
    @driver.displose unless @driver.nil?
  end
end
