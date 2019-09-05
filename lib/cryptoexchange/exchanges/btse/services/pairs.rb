module Cryptoexchange::Exchanges
  module Btse
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btse::Market::API_URL}/market_summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            base, target = pair.split('-')

            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Btse::Market::NAME
            })
          end
        end
      end
    end
  end
end
