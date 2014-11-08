java_import 'javax.swing.SwingUtilities'
java_import 'java.lang.Runnable'
java_import 'javax.swing.JFrame'

class Main
  MAIN_WINDOW_NAME = 'Auction Sniper Main'
  STATUS_JOINING = 'Joining'
  SNIPER_STATUS_NAME = 'sniper status'
  attr_writer :ui

  def initialize sniper_id, sniper_password, item_id
    start_user_interface
  end

  def self.main sniper_id, sniper_password, item_id
    main = Main.new sniper_id, sniper_password, item_id
  end

  def start_user_interface
    SwingUtilities.invoke_and_wait(TheRunner.new self)
  end
end

class TheRunner
  include Runnable

  def initialize main
    @main = main
  end

  def run
    @main.ui = MainWindow.new
  end
end

class MainWindow < JFrame
  def initialize
    super 'Auction Sniper'
    set_name Main::MAIN_WINDOW_NAME
    set_default_close_operation JFrame::EXIT_ON_CLOSE
    set_visible true
  end
end
