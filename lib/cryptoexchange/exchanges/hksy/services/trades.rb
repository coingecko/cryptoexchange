module Cryptoexchange::Exchanges
  module Hksy
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Hksy::Market::TRADE_API_URL}/selectClinchInfoByCoinName?coinName=#{base}&payCoinName=#{target}"
        end

        def adapt(output, market_pair)
          data = output["model"]
          data.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['createtime'].to_i
            tr.payload   = trade
            tr.market    = Hksy::Market::NAME
            tr
          end
        end
      end
    end
  end
end
