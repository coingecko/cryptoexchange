module Cryptoexchange::Exchanges
  module BitforexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://www.bitforex.com/contract/swap/contract/listAll"

        def fetch
          output = super
          adapt(output["data"])
        end

        def adapt(output)
          output.map do |value|
            Cryptoexchange::Models::MarketPair.new(
              base:   value["baseSymbol"],
              target: value["quoteSymbol"],
              market: BitforexFutures::Market::NAME,
              contract_interval: 'perpetual',
              inst_id: value["symbol"]
            )
          end
        end
      end
    end
  end
end
