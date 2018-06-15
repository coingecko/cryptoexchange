module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Coinut::Authentication.new(
            :trades,
            Cryptoexchange::Exchanges::Coinut::Market::NAME
          )
          authentication.validate_credentials!

          payload_ = payload(market_pair)
          headers = authentication.headers(payload_)
          output = fetch_using_post(ticker_url, payload_, headers)
          adapt(output, market_pair)
        end

        def payload(market_pair)
          '{"nonce":' + SecureRandom.random_number(99999).to_s + ',"request":"inst_trade", "inst_id":' + market_pair.inst_id + ' }'
        end


        def ticker_url
          Cryptoexchange::Exchanges::Coinut::Market::API_URL
        end

        def adapt(output, market_pair)
          output["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinut::Market::NAME
            tr.trade_id  = trade["trans_id"]
            tr.type      = trade["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["qty"]
            tr.timestamp = trade["timestamp"]
            tr.payload   = trade
            tr
          end
        end
        
      end
    end
  end
end
