module Cryptoexchange::Exchanges
  module BtcAlpha
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BtcAlpha::Market::API_URL}/pairs/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['name'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: BtcAlpha::Market::NAME
            )
          end
        end
      end
    end
  end
end
