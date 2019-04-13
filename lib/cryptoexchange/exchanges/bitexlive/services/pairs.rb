module Cryptoexchange::Exchanges
  module Bitexlive
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitexlive::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            next unless ticker['isFrozen'] == '0'
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitexlive::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
