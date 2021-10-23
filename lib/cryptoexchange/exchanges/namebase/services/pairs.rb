module Cryptoexchange::Exchanges
  module Namebase
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Namebase::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["symbols"].map do |pair|
            next if pair["status"] != "TRADING"

            base = pair["baseAsset"]
            target = pair["quoteAsset"]
            next unless base && target

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Namebase::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
