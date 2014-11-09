java_import com.objogate.wl.swing.driver.JFrameDriver
java_import com.objogate.wl.swing.driver.JLabelDriver
java_import com.objogate.wl.swing.gesture.GesturePerformer
java_import com.objogate.wl.swing.AWTEventQueueProber

module Hamcrest
  java_import org.hamcrest.Matchers
end

class AuctionSniperDriver < JFrameDriver

  def initialize (timeoutMillis) 
    super(GesturePerformer.new, JFrameDriver.top_level_frame(self.class.named(Main::MAIN_WINDOW_NAME), self.class.showing_on_screen()), AWTEventQueueProber.new(timeoutMillis, 100))
  end

  def shows_sniper_status(status_text) 
    JLabelDriver.new(self, self.class.named(Main::SNIPER_STATUS_NAME)).has_text(equalTo(status_text))
  end

  def method_missing(method_name, *args, &block)
    begin
      Hamcrest::Matchers.send(method_name, *args)
    rescue NoMethodError
      super
    end
  end
end
