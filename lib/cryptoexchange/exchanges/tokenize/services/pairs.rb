module Cryptoexchange::Exchanges
  module Tokenize
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokenize::Market::API_URL}/market/getmarketsummaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |output|
            base, target = output['market'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Tokenize::Market::NAME
            )
          end
        end
      end
    end
  end
end
