module Cryptoexchange::Exchanges
  module Bitlish
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)['list'].select { |pair| pair['data'] != nil}
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitlish::Market::API_URL}/ohlcv"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair['data'].keys[0].upcase
            base, target = symbol.split(/(BTC$)+|(ETH$)+(.*)|(USDT$)+(.*)|(EUR$)+(.*)|(GBP$)+(.*)|(RUB$)+(.*)|(USD$)+(.*)|(JPY$)+(.*)|(TDT$)+(.*)/)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitlish::Market::NAME
            )
            adapt(market_pair, pair['data'].values[0])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitlish::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
