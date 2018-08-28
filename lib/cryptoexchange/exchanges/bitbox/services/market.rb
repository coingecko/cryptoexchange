module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['responseData'], market_pair)
        end

        def volume_ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/v1/outpost/ohlc?currencyPairs=#{market_pair.target}.#{market_pair.base}&timeFrame=1800&limit=100"
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/v1/outpost/ohlc?currencyPairs=#{market_pair.target}.#{market_pair.base}&timeFrame=60&limit=1"
        end

        def adapt(output, market_pair)
          volume_resp = HTTP.timeout(:write => 2, :connect => 15, :read => 18).follow.get(volume_ticker_url(market_pair))
          volume_output = JSON.parse volume_resp.body
          total_volume = volume_output['responseData'].values[0].select do |s| 
            s["closeTime"]/1000 > (Time.now.to_i - (60 * 60 * 24))
          end.inject(0) { |sum, s| sum + (s["volume"] * s["close"]) }

          output = output.values[0][0]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitbox::Market::NAME
          ticker.last = NumericHelper.to_d(output['close'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = total_volume
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
