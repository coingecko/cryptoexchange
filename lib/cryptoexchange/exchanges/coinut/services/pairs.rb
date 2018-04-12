module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        include CoinutHelper
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"        

        #specify username and api_key in yml file. E.g.
        # coinut:
        #   username: <username>
        #   key: <api_key>
        
        def fetch
          if auth_file_exist?          
            output = prepare_and_send_request
            adapt(output)
          else
            raise Cryptoexchange::Error, { response: "Must include auth file named cryptoexchange_api_keys.yml in config/cryptoexchange"}
          end
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
