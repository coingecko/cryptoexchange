module Cryptoexchange::Exchanges
  module Altilly
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
          "#{Cryptoexchange::Exchanges::Altilly::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair['symbol'].upcase
            base, target = symbol.split(/(BTC$)+|(ETH$)+|(USDT$)+|(LTC$)+/)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Altilly::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Altilly::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = DateTime.parse(output['timestamp']).to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
