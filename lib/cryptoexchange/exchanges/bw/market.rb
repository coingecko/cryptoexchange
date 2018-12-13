module Cryptoexchange::Exchanges
  module Bw
    class Market < Cryptoexchange::Models::Market
      NAME = 'bw'
      API_URL = 'https://www.bw.com/exchange/config/controller'

      def self.trade_page_url(args={})
        "https://www.bw.com/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
