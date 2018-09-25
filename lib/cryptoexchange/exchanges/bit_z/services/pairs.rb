module Cryptoexchange::Exchanges
  module BitZ
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitZ::Market::API_URL}/Market/symbolList"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['data']
          pairs.map do |_key, value|
            Cryptoexchange::Models::MarketPair.new(
              base:   value['coinFrom'],
              target: value['coinTo'],
              market: BitZ::Market::NAME
            )
          end
        end
      end
    end
  end
end
