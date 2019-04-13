module Cryptoexchange::Exchanges
  module Biki
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Biki::Market::API_URL}/get_allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"]["ticker"].map do |pair|
            base, target = Biki::Market.separate_symbol(pair["symbol"])
            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Biki::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
