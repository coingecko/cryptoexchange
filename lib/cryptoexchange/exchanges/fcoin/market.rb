module Cryptoexchange::Exchanges
  module Fcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'fcoin'
      API_URL = 'https://api.fcoin.com/v2'

      def self.trade_page_url(args={})
        "https://exchange.fcoin.com/ex/spot/main/#{args[:base].downcase}/#{args[:target].downcase}"
      end
    end
  end
end
