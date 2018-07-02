module Cryptoexchange::Exchanges
  module Tokenomy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokenomy::Market::API_URL}/summaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['tickers'].map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Tokenomy::Market::NAME
            )
          end
        end
      end
    end
  end
end
