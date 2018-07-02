module Cryptoexchange::Exchanges
  module Tokenomy
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
          "#{Cryptoexchange::Exchanges::Tokenomy::Market::API_URL}/summaries"
        end

        def adapt_all(output)
          timestamp = output['server_time']
          output['tickers'].map do |pair, ticker|
            base, target = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Tokenomy::Market::NAME
            )
            adapt(market_pair, ticker, timestamp)
          end
        end

        def adapt(market_pair, output, timestamp)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Tokenomy::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.ask = NumericHelper.to_d(output['sell'])
          ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.volume = NumericHelper.to_d(output["vol_#{market_pair.base.downcase}"])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])

          ticker.timestamp = timestamp
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
