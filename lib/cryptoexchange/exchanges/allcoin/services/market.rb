module Cryptoexchange::Exchanges
  module Allcoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/#{market_pair.base}#{market_pair.target}/money/ticker"
        end

        def adapt(output)
          ticker = Cryptoexchange::Models::Ticker.new
          base = output['ticker']['vol']
          target = output['ticker']['high']

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Allcoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['date']['dataUpdateTime'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
