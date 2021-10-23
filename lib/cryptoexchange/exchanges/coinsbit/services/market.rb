module Cryptoexchange::Exchanges
  module Coinsbit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinsbit::Market::API_URL}/public/ticker?market=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          result = output['result']
          handle_invalid(result)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Coinsbit::Market::NAME
          ticker.ask = NumericHelper.to_d(result['ask'])
          ticker.bid = NumericHelper.to_d(result['bid'])
          ticker.last = NumericHelper.to_d(result['last'])
          ticker.high = NumericHelper.to_d(result['high'])
          ticker.low = NumericHelper.to_d(result['low'])
          ticker.volume = NumericHelper.to_d(result['volume'])
          ticker.change = NumericHelper.to_d(result['change'])
          ticker.timestamp = nil
          ticker.payload = result
          ticker
        end

        def handle_invalid(output)
          if output.empty?
            raise Cryptoexchange::ResultParseError, { response: output }
          end
        end
      end
    end
  end
end
