require 'javalib/hamcrest-all-SNAPSHOT.jar'
require 'javalib/windowlicker-swing-DEV.jar'
require 'javalib/windowlicker-core-DEV.jar'

java_import com.objogate.wl.swing.driver.JFrameDriver
java_import com.objogate.wl.swing.driver.JLabelDriver
java_import com.objogate.wl.swing.gesture.GesturePerformer
java_import com.objogate.wl.swing.AWTEventQueueProber

module Hamcrest
  java_import org.hamcrest.Matchers
end

class AuctionSniperDriver < JFrameDriver
  def initialize (timeoutMillis) 
    super(GesturePerformer.new, JFrameDriver.topLevelFrame(self.class.named(Main::MAIN_WINDOW_NAME), self.class.showingOnScreen()), AWTEventQueueProber.new(timeoutMillis, 100))
  end

  def showsSniperStatus(statusText) 
    JLabelDriver.new(self, self.class.named(Main::SNIPER_STATUS_NAME)).hasText(equalTo(statusText))
  end

  def method_missing(method_name, *args, &block)
    begin
      Hamcrest::Matchers.send(method_name, *args)
    rescue NoMethodError
      super
    end
  end
end
