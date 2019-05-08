module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}=#{Cryptoexchange::Exchanges::Uniswap::Market::API_KEY}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base = pair["tokenSymbol"]
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
