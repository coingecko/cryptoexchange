module Cryptoexchange::Exchanges
  module Gdax
    module Services
      class Subscription < Cryptoexchange::Services::Subscription
        def subscribe_event(pairs)
          pairs_to_subscribe = list_pairs(pairs)
          subscription_message = {
              "type": "subscribe",
              "product_ids":
                  pairs_to_subscribe,
              "channels": [
                  # "level2",
                  # "heartbeat",
                  "matches",
                  {
                      "name": "ticker",
                      "product_ids":
                          pairs_to_subscribe
                  }
              ]
          }.to_json
        end

        def list_pairs(pairs)
          list = []
           pairs.each do |pair| list << ("#{pair.base}-#{pair.target}")
           end
          list
        end
      end
    end
  end
end
