module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/v2/market/prices"

        def fetch
          output = super
          adapt(output['responseData'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['b'],
                              target: pair['a'],
                              market: Bitbox::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
