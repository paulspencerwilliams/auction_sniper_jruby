java_import 'java.util.concurrent.ArrayBlockingQueue'
java_import 'java.util.concurrent.TimeUnit'
java_import 'org.hamcrest.core.IsNull'
java_import 'org.hamcrest.core.Is'
java_import 'org.hamcrest.MatcherAssert'

require 'blather/client/dsl'

class FakeAuctionServer 

  AUCTION_PASSWORD = 'secr3t'
  AUCTION_RESOURCE = 'Auction'

  def initialize item_id
    @message_listener = SingleMessageListener.new
    @item_id = item_id
  end
  
  attr_reader :item_id

  def start_selling_item
    @client = Blather::Client.setup item_id_as_login, AUCTION_PASSWORD
    Thread.new do
      EM.run do
        @client.run
      end

      client.register_handler :message do |m|
        @message_listener.process_message m
      end
    end
  end

  def has_received_join_request_from_snipper 
    @message_listener.receives_a_message
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
    MatcherAssert.assert_that("Message", @messages.poll(5, TimeUnit::SECONDS), Is.is(IsNull.not_null_value)) 
  end
end
