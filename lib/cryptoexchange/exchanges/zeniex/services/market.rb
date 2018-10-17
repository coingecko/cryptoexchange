module Cryptoexchange::Exchanges
  module Zeniex
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
          "#{Cryptoexchange::Exchanges::Zeniex::Market::API_URL}/open/api/get_tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            symbol = pair['symbol'].upcase
            base, target = symbol.split(/(BTC$)+(.*)|(ETH$)+(.*)/)
            next unless base && target
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Zeniex::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Zeniex::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.ask = NumericHelper.to_d(output['sell'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['vol'])
          ticker.timestamp = output['time']/1000
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
