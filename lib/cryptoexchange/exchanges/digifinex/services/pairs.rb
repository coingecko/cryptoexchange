module Cryptoexchange::Exchanges
  module Digifinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Digifinex::Market::API_URL}/ticker?apiKey=15cad9a55217c4"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['ticker'].map do |pair, ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Digifinex::Market::NAME
            )
          end
        end
      end
    end
  end
end
