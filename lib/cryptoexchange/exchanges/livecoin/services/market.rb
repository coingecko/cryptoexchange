module Cryptoexchange::Exchanges
  module Livecoin
    module Services
      class Market < Cryptoexchange::Services::Market

        def fetch(market_pair)
          @output ||= super(market_url)
          adapt(@output, market_pair)
        end

        def market_url
          "#{Cryptoexchange::Exchanges::Livecoin::Market::API_URL}/exchange/ticker"
        end

        def adapt(output, market_pair)
          data = output.find { |s| s['symbol'] == "#{market_pair.base}/#{market_pair.target}" }

          base, target = data['symbol'].split('/')

          ticker = Livecoin::Models::Ticker.new
          ticker.base = base
          ticker.target = target
          ticker.market = Livecoin::Market::NAME
          ticker.last = data['last']
          ticker.bid = data['best_bid']
          ticker.ask = data['best_ask']
          ticker.high = data['high']
          ticker.low = data['low']
          ticker.volume = data['volume']
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = data
          ticker
        end
      end
    end
  end
end
