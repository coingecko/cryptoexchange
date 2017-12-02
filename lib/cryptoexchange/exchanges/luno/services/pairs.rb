module Cryptoexchange::Exchanges
  module Luno
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Luno::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['tickers'].map do |ticker|
            base = ticker['pair'][0..2]
            target = ticker['pair'][3..5]

            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Luno::Market::NAME
            })
          end
        end
      end
    end
  end
end
