module Cryptoexchange::Exchanges
  module Piexgo
    class Market < Cryptoexchange::Models::Market
      NAME = 'piexgo'
      API_URL = 'https://api.piexgo.com'

      def self.trade_page_url(args={})
        "https://www.piexgo.com/exchange/market/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
