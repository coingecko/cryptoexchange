module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          username, api_key = retrieve_auth_credentials
          output = prepare_and_send_request(username, api_key, market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"
        end

        def adapt(output, market_pair)
          output["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["trans_id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinut::Market::NAME
            tr.type      = trans["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["qty"]
            tr.timestamp = trade["timestamp"]
            tr.payload   = trade
            tr
          end
        end

        private

        def prepare_and_send_request(username, api_key, market_pair)
          payload = generate_payload(market_pair.inst_id)
          hmac_hex = generate_signature(api_key, payload)
          headers = generate_headers(username, hmac_hex)
          output = fetch_using_post(ticker_url, payload, headers)
        end

        def retrieve_auth_credentials
          auth_credentials = YAML.load_file(auth_details_path)
          return auth_credentials[:username], auth_credentials[:api_key]
        end

        def auth_details_path
          "config/cryptoexchange/#{exchange_class::NAME}_auth.yml"
        end

        def generate_nonce
          SecureRandom.random_number(99999)
        end

        def generate_payload(market_pair_id)
          '{"nonce":' + generate_nonce.to_s + ',"request":"inst_trade", "inst_id":' + market_pair_id + ' }'
        end

        def generate_signature(api_key, payload)
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
        end

        def generate_headers(username, hmac_hex)
          {"X-USER" => username, "X-SIGNATURE" => hmac_hex}
        end  
      end
    end
  end
end
