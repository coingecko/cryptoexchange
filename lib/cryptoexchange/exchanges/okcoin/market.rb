module Cryptoexchange::Exchanges
  module Okcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'okcoin'
      API_URL = 'https://www.okcoin.com/api/spot/v3'

      def self.trade_page_url(args={})
        "https://www.okcoin.com/market#product=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
