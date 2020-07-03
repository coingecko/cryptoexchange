module Cryptoexchange::Exchanges
  module TraderOne
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TraderOne::Market::API_URL}/markets/tickers?quoteCurrency"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair.first.split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: TraderOne::Market::NAME
            )
          end
        end
      end
    end
  end
end