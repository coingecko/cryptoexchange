module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/asset_pairs"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: HashHelper.dig(pair, 'base_asset', 'symbol'),
                              target: HashHelper.dig(pair, 'quote_asset', 'symbol'),
                              market: Bigone::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
