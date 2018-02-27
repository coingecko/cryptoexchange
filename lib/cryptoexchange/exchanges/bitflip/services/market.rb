module Cryptoexchange::Exchanges
  module Bitflip
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
        BUY_SELL = []

        def fetch(market_pair)
          pair_combined = "#{market_pair.base.downcase}:#{market_pair.target.downcase}"
          raw_output = HTTP.post(ohlc_url, :body => "{\"pair\":\"#{pair_combined}\"}")
          ohlc_output = JSON.parse(raw_output)
          buy_sell_output = buy_sell(market_pair)
          adapt(ohlc_output, buy_sell_output, market_pair)
        end

        def ohlc_url
          "#{Cryptoexchange::Exchanges::Bitflip::Market::API_URL}market.getOHLC"
        end

        def buy_sell_url
          "#{Cryptoexchange::Exchanges::Bitflip::Market::API_URL}market.getRates"
        end

        def buy_sell(market_pair)
          if BUY_SELL.empty?
            raw_output = HTTP.post(buy_sell_url)
            output = JSON.parse(raw_output)
            BUY_SELL.push(output[1])
          end
            adapt_buy_sell(market_pair)
        end

        def adapt_buy_sell(market_pair)
          BUY_SELL.flatten.select{ |pair| pair["pair"] == "#{market_pair.base}:#{market_pair.target}"}
        end

        def adapt(ohlc_output, buy_sell_output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitflip::Market::NAME
          ticker.ask = NumericHelper.to_d(buy_sell_output[0]['sell'])
          ticker.bid = NumericHelper.to_d(buy_sell_output[0]['buy'])
          ticker.last = NumericHelper.to_d(ohlc_output[1]['close'])
          ticker.high = NumericHelper.to_d(ohlc_output[1]['high'])
          ticker.low = NumericHelper.to_d(ohlc_output[1]['low'])
          ticker.volume = NumericHelper.to_d(ohlc_output[1]['volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = [ohlc_output[1], buy_sell_output[0]]
          ticker
        end
      end
    end
  end
end
