module Cryptoexchange::Exchanges
  module Waves
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Waves::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            base, target = pair['symbol'].split("/")
            next if base.nil? || base.empty? || target.nil? || target.empty?

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Waves::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
