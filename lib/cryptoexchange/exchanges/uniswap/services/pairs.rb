module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}/exchanges?key=#{Cryptoexchange::Exchanges::Uniswap::Market.api_key}"
        end

        def fetch
          output = fetch_via_api(pairs_url)
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            if pair["ethLiquidity"] > 0
              base = pair["tokenSymbol"]
              target = "ETH"
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Uniswap::Market::NAME
                              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
