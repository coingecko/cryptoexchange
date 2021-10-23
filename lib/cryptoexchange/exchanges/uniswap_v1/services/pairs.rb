module Cryptoexchange::Exchanges
  module UniswapV1
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "#{Cryptoexchange::Exchanges::UniswapV1::Market::API_URL}/exchanges?key=#{Cryptoexchange::Exchanges::UniswapV1::Market.api_key}"
        end

        def fetch
          output = fetch_via_api(pairs_url)
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base = pair["tokenSymbol"]
            target = "ETH"

            # Temporary workaround for duplicate symbols
            base = "#{pair['tokenSymbol']}-#{pair['token']}" if base == "ULT"

            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: UniswapV1::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
