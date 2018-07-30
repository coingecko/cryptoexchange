module Cryptoexchange::Exchanges
  module Zebpay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zebpay::Market::API_URL}/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base, target = output['pair'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Zebpay::Market::NAME
              )
          end
        end
      end
    end
  end
end
