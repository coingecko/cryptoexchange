module Cryptoexchange::Exchanges
  module BitsharesAssets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitsharesAssets::Market::API_URL}/asset/markets?asset=BTS"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base = output[0]
            target = "BTS"
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: BitsharesAssets::Market::NAME
            )
          end
        end
      end
    end
  end
end
