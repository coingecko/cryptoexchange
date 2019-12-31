module Cryptoexchange::Exchanges
  module Waves
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Waves::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Waves::Market.fetch_symbol
          output["data"].map do |ticker|
            base   = symbols[ticker['amountAsset']]
            next if base.nil?
            target   = symbols[ticker['priceAsset']] || "WAVES"
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Waves::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
