module Cryptoexchange::Exchanges
  module Etherflyer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Etherflyer::Market::API_URL}/market/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['ticker'].map do |pair|
            next unless pair['symbol']
            base, target = pair['symbol'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Etherflyer::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
