module Cryptoexchange::Exchanges
  module Bitso
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitso::Market::API_URL}/available_books"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["payload"].each do |pair|
            base_raw, target_raw = pair["book"].split("_")
            base, target = pair["book"].upcase.split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              base_raw: base_raw,
                              target_raw: target_raw,
                              market: Bitso::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
