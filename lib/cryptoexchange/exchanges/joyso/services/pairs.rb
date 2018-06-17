module Cryptoexchange::Exchanges
  module Joyso
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Joyso::Market::API_URL}/tickers/market"

        def fetch
          output = super
          adapt(output['tickers'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            target, base = pair['pair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Joyso::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
