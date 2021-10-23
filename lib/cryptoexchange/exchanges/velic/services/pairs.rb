module Cryptoexchange::Exchanges
  module Velic
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Velic::Market::API_URL}/public/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            target = output['base_coin']
            base   = output['match_coin']
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Velic::Market::NAME)
          end
        end
      end
    end
  end
end
