module Cryptoexchange::Exchanges
  module Chaoex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'chaoex'
      API_URL = 'https://www.chaoex.com/12lian'
    end
  end
end

module Cryptoexchange
  module Models
    module Chaoex
      class MarketPair < Cryptoexchange::Models::MarketPair
        attr_accessor :base_id, :target_id

        def initialize(params = {})
          super
          @base_id   = params[:base_id]
          @target_id = params[:target_id]
        end
      end
    end
  end
end
