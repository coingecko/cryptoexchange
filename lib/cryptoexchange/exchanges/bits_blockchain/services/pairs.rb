module Cryptoexchange::Exchanges
  module BitsBlockchain
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://www.bitsblockchain.net/moon/v1/market/currencyStatic"

        def fetch
          output = super
          market_pairs = []
          output['currencyStatic']['currencyPairs'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[1]["tradedCcy"],
                              target: pair[1]["settlementCcy"],
                              market: BitsBlockchain::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
