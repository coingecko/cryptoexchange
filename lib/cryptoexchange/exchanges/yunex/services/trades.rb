module Cryptoexchange::Exchanges
  module Yunex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Yunex::Market::API_URL}/api/order/trade/recent?symbol=#{base}_#{target}&count=10"
        end

        def adapt(output, market_pair)
          data = output["data"]["list"]

          data.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.type      = tradeBy trade['trade_by']
            tr.timestamp = timestamp trade['timestamp']
            tr.payload   = trade
            tr.market    = Yunex::Market::NAME
            tr
          end
        end

        def timestamp(nanosecond)
            sec = nanosecond / 1e9
            sec.to_i
        end

        def tradeBy(type)
            types = ""
            case type
            when 1
                types = "sell"
            when 2
                types = "buy"
            end
            types
        end

      end
    end
  end
end
