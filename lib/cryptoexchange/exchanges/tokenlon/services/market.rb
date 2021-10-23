module Cryptoexchange::Exchanges
  module Tokenlon
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
          "#{Cryptoexchange::Exchanges::Tokenlon::Market::API_URL}/get_market"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair["pairs"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Tokenlon::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Tokenlon::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.volume = NumericHelper.to_d(output["vol24h"])
          ticker.high = NumericHelper.to_d(output['high24h'])
          ticker.low = NumericHelper.to_d(output['low24h'])

          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
