module Cryptoexchange::Exchanges
  module Probitex
    class Market < Cryptoexchange::Models::Market
      NAME = 'probitex'
      API_URL = 'https://www.probitex.com/apis'

      def self.trade_page_url(args={})
        base = args[:base].downcase
        target = args[:target].downcase
        "https://www.probitex.com/trade/index/market/#{base}_#{target}"
      end
    end
  end
end
