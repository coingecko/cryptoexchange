module Cryptoexchange::Exchanges
  module Bitturk
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitturk::Market::API_URL}/exchangeinfo"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['Pair'].split(/(TRY$)+/)
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitturk::Market::NAME
            )
          end
        end
      end
    end
  end
end
