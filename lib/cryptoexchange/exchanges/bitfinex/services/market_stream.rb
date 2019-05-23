module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class MarketStream < Cryptoexchange::Services::MarketStream
        def url
          Cryptoexchange::Exchanges::Bitfinex::Market::WS_URL
        end

        def subscribe_event(market_pair)
          {
            event:   "subscribe",
            channel: "ticker",
            pair:    "#{market_pair.base}#{market_pair.target}"
          }.to_json
        end

        def valid_message?(message)
          message.is_a?(Array) && message.length == 11
        end

        def parse_message(message, market_pair)
          # [67452,6614.9,36.37426215,6615,71.7470363,42.2,0.0064,6614.9,9981.07371415,6741.4366438,6570]
          #
          # CHANNEL_ID	      integer	Channel ID
          # BID               float Price of last highest bid
          # BID_SIZE          float Size of the last highest bid
          # ASK               float Price of last lowest ask
          # ASK_SIZE          float Size of the last lowest ask
          # DAILY_CHANGE      float Amount that the last price has changed since yesterday
          # DAILY_CHANGE_PERC float Amount that the price has changed expressed in percentage terms
          # LAST_PRICE        float Price of the last trade.
          # VOLUME            float Daily volume
          # HIGH              float Daily high
          # LOW               float Daily low
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitfinex::Market::NAME
          ticker.ask       = NumericHelper.to_d(message[3])
          ticker.bid       = NumericHelper.to_d(message[1])
          ticker.last      = NumericHelper.to_d(message[7])
          ticker.high      = NumericHelper.to_d(message[9])
          ticker.low       = NumericHelper.to_d(message[10])
          ticker.volume    = NumericHelper.to_d(message[6])
          ticker.timestamp = nil
          ticker.payload   = message
          ticker
        end
      end
    end
  end
end
