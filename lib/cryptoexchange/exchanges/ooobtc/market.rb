module Cryptoexchange::Exchanges
  module Ooobtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'ooobtc'
      API_URL = 'https://api.ooobtc.com/open'

      def self.trade_page_url(args={})
        "https://www.ooobtc.com/trading?coin=#{args[:base]}&current=#{args[:target]}"
      end
    end
  end
end
