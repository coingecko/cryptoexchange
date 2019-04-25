module Cryptoexchange::Exchanges
  module Oex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Oex::Market::API_URL}/get_allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"]["ticker"].map do |pair|
            base, target = Oex::Market.separate_symbol(pair["symbol"])
            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Oex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
