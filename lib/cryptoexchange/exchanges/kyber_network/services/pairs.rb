module Cryptoexchange::Exchanges
  module KyberNetwork
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::KyberNetwork::Market::API_URL}/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output = output["data"]
          market_pairs = []
          output.each do |pair|
            target, base = pair["quote_symbol"], pair["base_symbol"]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: KyberNetwork::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
