module Cryptoexchange::Exchanges
  module Exrates
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exrates::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output.keys
          market_pairs = []
          pairs.each do |pair|
            base, target = pair.split('_')
            market_pairs << 
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target, 
              market: Exrates::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
