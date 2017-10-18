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
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/ticker?symbol=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Allcoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['date'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
