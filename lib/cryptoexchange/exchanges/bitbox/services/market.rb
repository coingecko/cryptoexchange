module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['responseData'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/v1/outpost/ohlc?currencyPairs=#{market_pair.target}.#{market_pair.base}&timeFrame=1800&limit=2"
        end

        def adapt(output, market_pair)
          output = output.values[0][0]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitbox::Market::NAME
          ticker.last = NumericHelper.to_d(output['close'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.timestamp = (output['closeTime']/1000)
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
