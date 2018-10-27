module Cryptoexchange::Exchanges
  module Paradex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Paradex::Authentication.new(
            :market,
            Paradex::Market::NAME
          )
          authentication.validate_credentials!

          headers = authentication.headers(payload: nil)
          output = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(ticker_url(market_pair), headers)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/tradeHistory?market=#{base}/#{target}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = Time.parse(trade['created']).to_i
            tr.payload   = trade
            tr.market    = Paradex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
