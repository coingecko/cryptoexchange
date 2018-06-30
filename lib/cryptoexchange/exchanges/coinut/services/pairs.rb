module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          authentication = Cryptoexchange::Exchanges::Coinut::Authentication.new(
            :pairs,
            Cryptoexchange::Exchanges::Coinut::Market::NAME
          )
          authentication.validate_credentials!

          payload_ = payload
          headers = authentication.headers(payload_)
          output = fetch_via_api_using_post(pairs_url, headers, payload_)
          adapt(output)
        end

        def payload
          '{"nonce":' + SecureRandom.random_number(99999).to_s + ',"request":"inst_list", "sec_type":"SPOT"}'
        end

        def pairs_url
          Cryptoexchange::Exchanges::Coinut::Market::API_URL
        end

        def adapt(output)
          output["SPOT"].map do |pairs, array|
            hash = array.first
            Cryptoexchange::Models::MarketPair.new(
              base: hash["base"],
              target: hash["quote"],
              inst_id: hash["inst_id"].to_s,
              market: Coinut::Market::NAME
            )
          end
        end

      end
    end
  end
end
