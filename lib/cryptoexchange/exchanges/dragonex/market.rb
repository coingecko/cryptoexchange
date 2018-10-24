module Cryptoexchange::Exchanges
  module Dragonex
    class Market < Cryptoexchange::Models::Market
      NAME = 'dragonex'
      API_URL = 'https://openapi.dragonex.io'

      def self.trade_page_url(args={})
        base = args[:base].downcase
        target = args[:target].downcase
        "https://dragonex.io/en-us/trade/index/#{base}_#{target}"
      end
    end
  end
end
