module Cryptoexchange::Exchanges
  module Bankera
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
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bankera::Market::API_URL}/tickers/#{base}-#{target}"
        end

        def adapt(output, market_pair)
          data = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bankera::Market::NAME
          ticker.bid       = NumericHelper.to_d(data['bid'])
          ticker.ask       = NumericHelper.to_d(data['ask'])
          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.volume    = NumericHelper.to_d(data['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
