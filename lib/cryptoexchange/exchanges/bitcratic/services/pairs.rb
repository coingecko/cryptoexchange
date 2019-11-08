module Cryptoexchange::Exchanges
  module Bitcratic
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitcratic::Market::API_URL}.com/config/main.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output = output["tokens"]
          pairs = output
          market_pairs = []
          pairs.each do |pair|
            base = pair["name"]
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: "ETH",
              market: Bitcratic::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
