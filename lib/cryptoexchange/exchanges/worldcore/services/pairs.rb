module Cryptoexchange::Exchanges
  module Worldcore
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Worldcore::Market::API_URL}/market/pairs"

        def fetch
          output = super
          market_pairs = []
          output['result']['pairs'].each do |pair|
            base, target = pair['pair']['pair_show'].split(' / ')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Worldcore::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
