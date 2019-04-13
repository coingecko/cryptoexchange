module Cryptoexchange
  module Services
    class MarketStream
      def url
        raise NotImplementedError, 'url method is not defined!'
      end

      def subscribe_event(market_pair)
        raise NotImplementedError, 'subscribe_event method is not defined!'
      end

      def valid_message?(message)
        raise NotImplementedError, 'valid_message? method is not defined!'
      end

      def parse_message(message, market_pair)
        raise NotImplementedError, 'parse_message method is not defined!'
      end
    end
  end
end
