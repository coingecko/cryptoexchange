module Cryptoexchange::Exchanges
  module Cbx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cbx::Market::API_URL}/asset_pairs"

        def fetch
          output = super
          output["data"].map do |output|
            base, target = output['name'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cbx::Market::NAME
            )
          end
        end
      end
    end
  end
end
