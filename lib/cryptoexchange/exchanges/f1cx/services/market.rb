module Cryptoexchange::Exchanges
  module F1cx
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::F1cx::Market::API_URL}/tickers/#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = F1cx::Market::NAME
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
