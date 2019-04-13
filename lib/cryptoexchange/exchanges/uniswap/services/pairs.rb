module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}/directory"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base = pair["symbol"]
            target = "ETH"
            inst_id = pair["exchangeAddress"]
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: inst_id,
                              market: Uniswap::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
