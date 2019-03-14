module Cryptoexchange::Exchanges
  module Zbmega
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zbmega::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output["ticker"]
          market_pairs = []
          pairs.each do |pair|
            base, target = pair["symbol"].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Zbmega::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
