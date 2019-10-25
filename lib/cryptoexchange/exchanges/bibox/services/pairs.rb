module Cryptoexchange::Exchanges
  module Bibox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bibox::Market::API_URL}/mdata?cmd=marketAll"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            next if pair["pair_type"] == 4

            Cryptoexchange::Models::MarketPair.new(
              base: pair['coin_symbol'],
              target: pair['currency_symbol'],
              market: Bibox::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
