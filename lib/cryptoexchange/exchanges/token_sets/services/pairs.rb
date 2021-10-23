module Cryptoexchange::Exchanges
  module TokenSets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "#{Cryptoexchange::Exchanges::TokenSets::Market::API_URL}/rebalancing_sets/explore"
        end

        def social_pairs_url
          "#{Cryptoexchange::Exchanges::TokenSets::Market::API_URL}/rebalancing_sets/explore?type=trading_pool"
        end

        def fetch
          pairs_output = fetch_via_api(pairs_url)
          social_pairs_output = fetch_via_api(social_pairs_url)
          output = pairs_output["detailed_rebalancing_sets"] + social_pairs_output["detailed_rebalancing_sets"]
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base = pair["symbol"]
            target = "USD"
            id = pair["id"]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: TokenSets::Market::NAME,
                              inst_id: id,
                            )
          end
          market_pairs
        end
      end
    end
  end
end
