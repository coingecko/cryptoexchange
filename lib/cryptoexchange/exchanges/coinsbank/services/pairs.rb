module Cryptoexchange::Exchanges
  module Coinsbank
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinsbank::Market::API_URL}/head"

        def fetch
          output = super
          adapt(output['pairs'])
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['base_code'],
              target: pair['quote_code'],
              market: Coinsbank::Market::NAME
            )
          end
        end
      end
    end
  end
end
