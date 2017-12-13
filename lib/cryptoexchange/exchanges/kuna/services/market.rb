module Cryptoexchange::Exchanges
  module Kuna
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
          "#{Cryptoexchange::Exchanges::Kuna::Market::API_URL}/tickers/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker_json      = output['ticker']
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kuna::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_json['sell'])
          ticker.bid       = NumericHelper.to_d(ticker_json['buy'])
          ticker.last      = NumericHelper.to_d(ticker_json['last'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.volume    = NumericHelper.to_d(ticker_json['vol'])
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
