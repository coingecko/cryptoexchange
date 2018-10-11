module Cryptoexchange::Exchanges
  module Incorex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Incorex::Market::API_URL}/pair_settings"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output.keys
          market_pairs = []
          pairs.each do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Incorex::Market::NAME
                            )
          end
          
          market_pairs
        end
      end
    end
  end
end
