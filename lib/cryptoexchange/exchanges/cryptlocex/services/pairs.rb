module Cryptoexchange::Exchanges
  module Cryptlocex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptlocex::Market::API_URL}/Index/marketInfo"

        def fetch
          output = super
          adapt(output['data']['market'])
        end

        def adapt(output)
          output.map do |output|
            base, target = output["ticker"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Cryptlocex::Market::NAME
            )
          end
        end
      end
    end
  end
end
