module Cryptoexchange::Exchanges
  module Bitforex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitforex::Market::API_URL}/market.act?cmd=getAllMatchTypeTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitforex::Market::NAME
            )
          end
        end
      end
    end
  end
end
