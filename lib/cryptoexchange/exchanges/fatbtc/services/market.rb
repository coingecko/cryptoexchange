module Cryptoexchange::Exchanges
  module Fatbtc
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
          "#{Cryptoexchange::Exchanges::Fatbtc::Market::API_URL}/allticker/1/"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair[1]['dspName'].split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Fatbtc::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Fatbtc::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.bid       = output['bis1'] ? NumericHelper.to_d(output['bis1'][0].to_f) : 'Nil'
          ticker.ask       = output['ask1'] ? NumericHelper.to_d(output['ask1'][0].to_f) : 'Nil'
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
