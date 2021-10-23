module Cryptoexchange::Exchanges
  module SatoWalletEx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SatoWalletEx::Market::API_URL}/Index/marketInfo"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"]["market"].map do |pair|
            base, target = pair["ticker"].split("_")

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: SatoWalletEx::Market::NAME,
            )
          end
        end
      end
    end
  end
end
