module Cryptoexchange::Exchanges
  module Maplechange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Maplechange::Market::API_URL}/markets.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            target, base = pair['name'].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Maplechange::Market::NAME
            )
          end
        end
      end
    end
  end
end
