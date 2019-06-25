module Cryptoexchange::Exchanges
  module BinanceDex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BinanceDex::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          output.map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: BinanceDex::Market::NAME
            )
          end
        end
      end
    end
  end
end
