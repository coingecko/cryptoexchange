module Cryptoexchange::Exchanges
  module Getbtc
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
          "#{Cryptoexchange::Exchanges::Getbtc::Market::API_URL}/stats?currency=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker_data = output['stats']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Getbtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_data['ask'])
          ticker.bid       = NumericHelper.to_d(ticker_data['bid'])
          ticker.last      = NumericHelper.to_d(ticker_data['last_price'])
          ticker.high      = NumericHelper.to_d(ticker_data['max'])
          ticker.low       = NumericHelper.to_d(ticker_data['min'])
          ticker.volume    = NumericHelper.to_d(ticker_data['total_btc_traded'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
