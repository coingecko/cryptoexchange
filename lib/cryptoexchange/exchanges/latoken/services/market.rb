module Cryptoexchange::Exchanges
  module Latoken
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Latoken::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair["symbol"].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Latoken::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Latoken::Market::NAME
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.volume = NumericHelper.to_d(output['volume24h']) / ticker.last
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
