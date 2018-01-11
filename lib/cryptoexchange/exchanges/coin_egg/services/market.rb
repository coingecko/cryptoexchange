module Cryptoexchange::Exchanges
  module CoinEgg
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
          "#{Cryptoexchange::Exchanges::CoinEgg::Market::API_URL}/api/v1/ticker?coin=#{market_pair.base.downcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = CoinEgg::Market::NAME
          ticker.ask = NumericHelper.to_d(output['sell'])
          ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['vol'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
