module Cryptoexchange::Exchanges
  module TokoCrypto
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TokoCrypto::Market::API_URL}/rates/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |ticker|
            base, target = ticker[0].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: TokoCrypto::Market::NAME
            )
          end
        end
      end
    end
  end
end
