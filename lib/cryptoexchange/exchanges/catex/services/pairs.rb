module Cryptoexchange::Exchanges
  module Catex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Catex::Market::API_URL}/token/list?page=1&pageSize=1000"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |ticker|
            base, target = ticker['pair'].split('/')
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
