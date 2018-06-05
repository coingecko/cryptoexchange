module Cryptoexchange::Exchanges
  module Bcex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL   = "#{Cryptoexchange::Exchanges::Bcex::Market::API_URL}/Api_Market/getPriceList"
        HTTP_METHOD = 'POST'

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs_list = []
          output.map do |target, base_info|
            base_info.map do |info|
              base = info['coin_from']
              pairs_list << [base, target]
            end
          end
          pairs_list.map do |pair|
            base, target = pair
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bcex::Market::NAME
            )
          end
        end
      end
    end
  end
end
