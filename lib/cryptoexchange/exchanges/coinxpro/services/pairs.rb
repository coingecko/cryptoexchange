module Cryptoexchange::Exchanges
  module Coinxpro
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinxpro::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["data"].each do |pair|
            base, target = pair["contract"].split('/')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinxpro::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
