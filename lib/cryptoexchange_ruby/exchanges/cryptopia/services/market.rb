module Cryptopia
  module Services
    class Market < CryptoexchangeRuby::Services::Market

      def fetch(market_pair)
        output = super(market_url(market_pair))
        adapt(output)
      end

      def market_url(market_pair)
        base = market_pair.base
        target = market_pair.target
        "#{Cryptopia::Market::API_URL}/GetMarket/#{base}_#{target}"
      end

      def adapt(output)
        # base
        # target
        # market (exchange_str)
        # last
        # bid
        # ask
        # high
        # low
        # avg
        # volume
        # timestamp

        data = output['Data']
        base, target = data['Label'].split('/')

        ticker = Cryptopia::Models::Ticker.new
        ticker.base = base
        ticker.target = target
        ticker.market = 'cryptopia'
        ticker.last = data['LastPrice']
        ticker.volume = data['Volume'] # TODO: Check if this is base denominated?
        ticker.timestamp = DateTime.now.to_time.to_i
        ticker
      end
    end
  end
end
