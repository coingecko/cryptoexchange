module Cryptoexchange::Exchanges
  module Unnamed
    class Market < Cryptoexchange::Models::Market
      NAME = 'unnamed'
      API_URL = 'https://api.unnamed.exchange/v1/Public'

      def self.trade_page_url(args={})
        "https://www.unnamed.exchange/Exchange/Basic?market=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
