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
            base, target = TokoCrypto::Market.separate_symbol(ticker["Name"])
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: TokoCrypto::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
