module Cryptoexchange::Exchanges
  module NLexch
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(self.ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          parameter = "#{market_pair.base.downcase}#{market_pair.target.downcase}"
          "#{Cryptoexchange::Exchanges::NLexch::Market::API_URL}/tickers/#{parameter}"
        end

        def adapt(output, market_pair)
          data_ticker = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = NLexch::Market::NAME
          ticker.last      = NumericHelper.to_d(data_ticker['last'])
          ticker.bid       = NumericHelper.to_d(data_ticker['buy'])
          ticker.ask       = NumericHelper.to_d(data_ticker['sell'])
          ticker.high      = NumericHelper.to_d(data_ticker['high'])
          ticker.low       = NumericHelper.to_d(data_ticker['low'])
          ticker.volume    = NumericHelper.to_d(data_ticker['vol'])
          ticker.timestamp = output['at'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
