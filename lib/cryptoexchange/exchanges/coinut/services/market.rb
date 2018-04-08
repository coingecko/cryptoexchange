module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          username, api_key = retrieve_auth_credentials
          output = prepare_and_send_request(username, api_key, market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinut::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['highest_buy'])
          ticker.low       = NumericHelper.to_d(output['lowest_sell'])
          ticker.volume    = NumericHelper.to_d(output['volume24'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end

        private

        def prepare_and_send_request(username, api_key, market_pair)
          payload = generate_payload(market_pair.inst_id)
          hmac_hex = generate_signature(api_key, payload)
          headers = generate_headers(username, hmac_hex)
          output = fetch_using_post(ticker_url, payload, headers)
        end

        def generate_payload(market_pair_id)
          '{"nonce":' + generate_nonce.to_s + ',"request":"inst_tick", "inst_id":' + market_pair_id + ' }'
        end

        def generate_signature(api_key, payload)
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
        end

        def generate_headers(username, hmac_hex)
          {"X-USER" => username, "X-SIGNATURE" => hmac_hex}
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
      end
    end
  end
end
