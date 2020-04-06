module Cryptoexchange::Exchanges
  module Bitbay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbay::Market::API_URL_2}/trading/stats"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["items"].map do |pair, ticker|
            next if ticker["l"] == nil
            base, target = pair.split("-")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitbay::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
