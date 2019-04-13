module Cryptoexchange::Exchanges
  module Coinasset
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinasset'
      API_URL = 'https://api.coinasset.co.th/api/v1'

      def self.trade_page_url(args={})
        "https://coinasset.co.th/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
