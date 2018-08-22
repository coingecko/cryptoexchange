module Cryptoexchange::Exchanges
  module Sigen
    class Market < Cryptoexchange::Models::Market
      NAME = 'sigen'
      API_URL = 'https://sigen.pro/v1/web-public/statistic'

      def self.trade_page_url(args={})
        "https://sigen.pro/trading/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
