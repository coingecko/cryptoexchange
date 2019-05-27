module Cryptoexchange::Exchanges
  module Prixbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        date = Date.today.to_s
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Prixbit::Market::API_URL}/ticker/24hr/#{date}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["result"].each do |pair|
            base, target = pair["quoteAsset"], pair["baseAsset"]
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Prixbit::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
