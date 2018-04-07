module Cryptoexchange::Exchanges
  module CryptoHub
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CryptoHub::Market::API_URL}/market/ticker/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair, _ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CryptoHub::Market::NAME
            )
          end
        end
      end
    end
  end
end
