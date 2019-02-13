module Cryptoexchange::Exchanges
  module Catex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Catex::Market::API_URL}/token/"

        def fetch
          outputs = []
          (1..3).each do |page_id|
            pair_url = PAIRS_URL + "list?page=#{page_id}&pageSize=50"
            puts pair_url
            output = fetch_via_api(pair_url)
            break if output.empty?
            outputs = outputs + output["data"]
          end
          adapt(outputs)
        end

        def adapt(output)
          output.map do |ticker|
            target, base = ticker['pair'].split('/')
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Catex::Market::NAME
            })
          end
        end
      end
    end
  end
end
