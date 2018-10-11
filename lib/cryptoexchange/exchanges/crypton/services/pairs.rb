module Cryptoexchange::Exchanges
  module Crypton
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crypton::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['result'].each do |pair|
            base, target = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Crypton::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
