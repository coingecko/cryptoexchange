module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/market/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            target, base = pair['market'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Upbit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
