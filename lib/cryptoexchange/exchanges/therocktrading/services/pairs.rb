module Cryptoexchange::Exchanges
  module Therocktrading
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Therocktrading::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          tickers = output['result']['tickers']
          tickers.each_key do |pair|
            base, target = pair[0,3], pair[3,6]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Therocktrading::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
