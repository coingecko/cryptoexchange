module Cryptoexchange::Exchanges
  module Bilaxy
    class Market
      NAME    = 'bilaxy'
      API_URL = 'http://api.bilaxy.com/v1'
      PAIRS_API_URL = 'https://www.bilaxy.com/api/v2/market/coins'
    end
  end
end

module Cryptoexchange
  module Models
    module Bilaxy
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
