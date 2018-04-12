module Cryptoexchange::Exchanges
  module Crxzone
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          result = IdFetcher.get_id(market_pair.base.upcase, market_pair.target.upcase)
          if result.length > 0
            pair = result.first
            pair_id = pair["ID"]
            output = super(trades_url(pair_id))
            adapt(output["Result"], market_pair)
          end
        end

        def trades_url(pair_id)
          "#{Cryptoexchange::Exchanges::Crxzone::Market::API_URL}/Trades?currencyPairID=#{pair_id}"
        end

        def adapt(output, market_pair)

          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["ID"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Crxzone::Market::NAME
            tr.type      = (trade["Type"].to_f > 0 ? "sell" : "buy")
            tr.price     = trade["Price"]
            tr.amount    = trade["Amount"]
            tr.timestamp = trade["TimeStamp"]
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
