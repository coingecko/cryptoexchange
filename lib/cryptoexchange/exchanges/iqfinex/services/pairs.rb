module Cryptoexchange::Exchanges
  module Iqfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Iqfinex::Market::API_URL}/v1/assets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['rows'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['left'],
              target: pair['right'],
              inst_id: pair['pair'],
              market: Iqfinex::Market::NAME
            )
          end
        end
      end
    end
  end
end
