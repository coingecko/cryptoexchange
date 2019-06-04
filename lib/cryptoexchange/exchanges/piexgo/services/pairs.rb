module Cryptoexchange::Exchanges
  module Piexgo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Piexgo::Market::API_URL}/api/v1/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |output|
            base, target = output["symbol"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Piexgo::Market::NAME
            )
          end
        end
      end
    end
  end
end
