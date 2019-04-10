module Cryptoexchange::Exchanges
  module Bitc3
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitc3::Market::API_URL}/iqtexQuote"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitc3::Market::NAME
            )
          end
        end
      end
    end
  end
end
