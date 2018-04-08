module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"

        #specify username and api_key in yml file. E.g.
        # :username: <username>
        # :api_key: <api_key>
        
        def fetch
          if auth_file_exist?          
            username, api_key = retrieve_auth_credentials(auth_details_path)
            output = prepare_and_send_request(username, api_key)
            adapt(output)
          else
            raise Cryptoexchange::Error, { response: "Must include auth file named coinut_auth.yml in config/cryptoexchange"}
          end
        end

        def adapt(output)
          output["SPOT"].map do |pairs, array|
            hash = array.first
            Cryptoexchange::Models::MarketPair.new(
              base: hash["base"],
              target: hash["quote"],
              market: Coinut::Market::NAME
            )
          end
        end

        private

        def prepare_and_send_request(username, api_key)
          payload = generate_payload
          hmac_hex = generate_signature(api_key, payload)
          headers = generate_headers(username, hmac_hex)
          output = fetch_via_api_using_post(self.class::PAIRS_URL, headers, payload)
        end

        def retrieve_auth_credentials
          auth_credentials = YAML.load_file(auth_details_path)
          return auth_credentials[:username], auth_credentials[:api_key]
        end

        def generate_nonce
          SecureRandom.random_number(99999)
        end

        def generate_payload 
          '{"nonce":' + generate_nonce.to_s + ',"request":"inst_list", "sec_type":"SPOT"}'
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
