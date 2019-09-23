module Cryptoexchange::Exchanges
  module Btcbox
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP['user-agent' => 'curl/7.54.0'].get "#{ticker_url(market_pair)}"
          output = JSON.parse(raw_output)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btcbox::Market::API_URL}/ticker?coin=#{market_pair.base.downcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Btcbox::Market::NAME
          ticker.ask = NumericHelper.to_d(output['sell'])
          ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
