module Cryptoexchange::Exchanges
  module Balancer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "https://raw.githubusercontent.com/balancer-labs/balancer-exchange/master/src/deployed.json"
        end

        def fetch
          data = fetch_via_api(pairs_url)
          assets_symbols = data["mainnet"]["tokens"].map { |r| r["symbol"] }
          adapt(assets_symbols)
        end

        def adapt(asset_symbols)
          market_pairs = []
          targets = ["ETH", "USDC", "DAI"]
          asset_symbols.each do |symbol|
            targets.each do |target|
              if target != symbol
                market_pairs << Cryptoexchange::Models::MarketPair.new(
                                  base: symbol,
                                  target: target,
                                  market: Balancer::Market::NAME
                                )
              end
            end
          end
          market_pairs
        end
      end
    end
  end
end
