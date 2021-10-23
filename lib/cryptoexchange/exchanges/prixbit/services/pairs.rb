module Cryptoexchange::Exchanges
  module Prixbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          output = fetch_via_api(pairs_url)
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

        def pairs_url
          "#{Cryptoexchange::Exchanges::Prixbit::Market::API_URL}/ticker/24hr/#{date_now}"
        end

        def date_now
          Date.today.to_s
        end
      end
    end
  end
end
