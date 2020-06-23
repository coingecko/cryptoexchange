module Cryptoexchange::Exchanges
  module XbtPrime
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::XbtPrime::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            next unless pair['name'].include?('/')

            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: XbtPrime::Market::NAME
                            )
          end.compact
          market_pairs
        end
      end
    end
  end
end
