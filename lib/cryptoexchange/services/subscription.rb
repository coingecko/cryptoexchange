module Cryptoexchange
  module Services
    class Subscription
      def subscribe_event(market_pair)
        raise NotImplementedError, 'subscribe_event method is not defined!'
      end

      def list_pairs(market_pair)
        raise NotImplementedError, 'list_pairs method is not defined!'
      end
    end
  end
end
