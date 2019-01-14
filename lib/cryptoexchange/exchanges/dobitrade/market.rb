module Cryptoexchange::Exchanges
  module Dobitrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'dobitrade'
      API_URL = 'https://api.dobiex.io'

      def self.trade_page_url(args={})
        "https://www.dobiex.io/zh/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
