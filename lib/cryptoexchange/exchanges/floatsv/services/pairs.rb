module Cryptoexchange::Exchanges
  module Floatsv
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Floatsv::Market::API_URL}/spot/v3/instruments/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base, target = output["instrument_id"].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Floatsv::Market::NAME
            )
          end
        end
      end
    end
  end
end
