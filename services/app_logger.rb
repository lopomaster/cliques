
require 'logger'

class AppLogger

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.debug message
    logger.debug message
  end

end