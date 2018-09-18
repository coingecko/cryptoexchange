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

module Cryptoexchange
  module Models
    module Dragonex
      class MarketPair < Cryptoexchange::Models::MarketPair
        attr_accessor :id

        def initialize(params = {})
          super
          @id = params[:id]
        end
      end
    end
  end
end
