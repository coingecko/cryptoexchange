module Cryptoexchange::Exchanges
  module Bitconnect
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitconnect::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          markets = output['markets']
          markets.map do |value|
            target, base = value['marketname'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitconnect::Market::NAME
            )
          end
        end
      end
    end
  end
end
