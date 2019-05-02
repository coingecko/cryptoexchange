module Cryptoexchange::Exchanges
  module Golix
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
          "#{Cryptoexchange::Exchanges::Golix::Market::API_URL}/tickers/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Golix::Market::NAME
          ticker.last      = NumericHelper.to_d(output['ticker']['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['ticker']['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['ticker']['low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'].to_f)
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'].to_f)
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
