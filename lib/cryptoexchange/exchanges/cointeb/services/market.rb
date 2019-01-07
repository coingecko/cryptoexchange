module Cryptoexchange::Exchanges
    module cointeb
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
            "#{Cryptoexchange::Exchanges::Cointeb::Market::API_URL}/tickers"
          end
           def adapt_all(output)
            output.map do |pair|
              base, target = pair[0].split('_')
              market_pair  = Cryptoexchange::Models::MarketPair.new(
                base:   base.upcase,
                target: target.upcase,
                market: Cointeb::Market::NAME
              )
              adapt(market_pair, pair[1])
            end
          end
          def adapt(output, market_pair)
            result = output['result']
            ticker = Cryptoexchange::Models::Ticker.new
            ticker.base = market_pair.base
            ticker.target = market_pair.target
            ticker.market = Cointeb::Market::NAME
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
        end
      end
    end
  end