module Cryptoexchange::Exchanges
  module SixX
    class Market < Cryptoexchange::Models::Market
      NAME = 'six_x'
      API_URL = 'https://exapi.6x.com/exapi'

      def self.trade_page_url(args={})
        "https://www.6x.com/market?symbol=#{args[:base]}%2F#{args[:target]}&board=0"
      end
    end
  end
end
