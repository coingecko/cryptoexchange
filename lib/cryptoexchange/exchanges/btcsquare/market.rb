module Cryptoexchange::Exchanges
  module Btcsquare
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcsquare'
      API_URL = 'https://www.btcsquare.net/api/v1'

      def self.trade_page_url(args={})
        "https://www.btcsquare.net/exchange/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
