module Cryptoexchange::Exchanges
  module Resfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Resfinex::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output["data"]
          market_pairs = []
          pairs.each do |pair|
            base, target = pair["pair"].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Resfinex::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
