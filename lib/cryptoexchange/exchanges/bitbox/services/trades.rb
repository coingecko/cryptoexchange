module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output['responseData'], market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/v2/market/transactions?marketType=#{market_pair.target}&coinType=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['transactionNo']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitbox::Market::NAME
            tr.type      = trade['d'].downcase
            tr.price     = trade['c']
            tr.amount    = trade['a']
            tr.timestamp = (trade['b']/1000).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
