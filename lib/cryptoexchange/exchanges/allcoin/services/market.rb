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
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/Api_Order/ticker?symbol=#{market_pair.base.downcase}2#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Allcoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'].to_f)
          ticker.bid       = NumericHelper.to_d(output['buy'].to_f)
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.volume    = NumericHelper.to_d(output['vol'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
