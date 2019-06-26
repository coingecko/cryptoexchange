module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          interval_code = Cryptoexchange::Exchanges::BitflyerFutures::Market::INTERVAL_CODE_LIST[market_pair.contract_interval]
          if market_pair.contract_interval == "perpetual"
            product_code = "#{interval_code}_#{market_pair.base}_#{market_pair.target}"
          else
            product_code = "#{market_pair.base}#{market_pair.target}_#{interval_code}"
          end

          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/executions?product_code=#{product_code}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['size']
            Time.parse(trade['exec_date']).to_i
            tr.timestamp = Time.parse(trade['exec_date']).to_i
            tr.payload   = trade
            tr.market    = BitflyerFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
