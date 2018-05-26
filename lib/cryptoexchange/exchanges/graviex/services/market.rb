module Cryptoexchange::Exchanges
  module Graviex
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
          market = "#{market_pair.base}#{market_pair.target}".downcase!
          "#{Cryptoexchange::Exchanges::Graviex::Market::API_URL}/tickers/#{market}.json"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker_json      = output['ticker']
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Graviex::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_json['buy'])
          ticker.ask       = NumericHelper.to_d(ticker_json['sell'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.last      = NumericHelper.to_d(ticker_json['last'])
          ticker.volume    = NumericHelper.to_d(ticker_json['vol'])
          ticker.timestamp = ticker_json['at'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
