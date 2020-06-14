module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        STABLECOINS_TARGETS = %w{ DAI USDC USDT }
        WETH_TARGET = ["WETH"]
        RECOGNIZED_TARGETS = STABLECOINS_TARGETS + WETH_TARGET

        def pairs_url
          "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}/exchanges?platform=uniswap-v2&key=#{Cryptoexchange::Exchanges::Uniswap::Market.api_key}"
        end

        def fetch
          output = fetch_via_api(pairs_url)
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          addresses = output["results"].map { |r| r["assets"].map { |a| a["address"] } }.flatten.uniq

          addresses.each do |address|
            base = address
            target = "ETH"

            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Uniswap::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
