java_import 'java.util.concurrent.ArrayBlockingQueue'
require 'blather/client/dsl'

class FakeAuctionServer 

  AUCTION_PASSWORD = 'secr3t'
  AUCTION_RESOURCE = 'Auction'

  def initialize item_id
    @messageListener = SingleMessageListener.new
    @item_id = item_id
  end

  def start_selling_item
    @client = Blather::Client.setup item_id_as_login, AUCTION_PASSWORD
    Thread.new do
      EM.run do
        @client.run
      end

      client.register_handler :message do |m|
        @messageListener.process_message m
      end
    end
  end

  def has_received_join_request_from_snipper 
    messageListener.receives_a_message
  end

  def stop
  end

  def item_id_as_login 
    "auction-#{@item_id}@localhost"
  end
end

class SingleMessageListener
  def initialize
    @messages = ArrayBlockingQueue.new 1
  end

  def process_message(message)
    @messages.add message
  end

  def receives_a_message
    assert_that("Message", messages.poll(5, SECONDS), is(not_null_value)) 
  end
end
