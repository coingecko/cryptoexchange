module Cryptoexchange::Exchanges
  module CryptoBridge
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CryptoBridge::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            base, target = pair["id"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CryptoBridge::Market::NAME
            )
          end
        end
      end
    end
  end
end
