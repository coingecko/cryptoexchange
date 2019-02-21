module Cryptoexchange::Exchanges
  module Altmarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Altmarkets::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair["name"].split('/')[0],
              target: pair["name"].split('/')[1],
              inst_id: pair["id"],
              market: Altmarkets::Market::NAME
            )
          end
        end
      end
    end
  end
end
