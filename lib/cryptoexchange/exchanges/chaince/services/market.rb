module Cryptoexchange::Exchanges
  module Chaince
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
          "#{Cryptoexchange::Exchanges::Chaince::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair[0].split(/(eos)+(.*)|(usdt)+(.*)/).reject(&:empty?)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Chaince::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Chaince::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
