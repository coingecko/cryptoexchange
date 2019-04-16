module Cryptoexchange::Exchanges
  module IndependentReserve
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::IndependentReserve::Market::API_URL}/GetValidPrimaryCurrencyCodes"
        TARGET_URL = "#{Cryptoexchange::Exchanges::IndependentReserve::Market::API_URL}/GetValidSecondaryCurrencyCodes"

        def fetch
          raw_base = super
          request = HTTP.accept(:json).get(TARGET_URL)
          raw_target = request.parse :json

          adapt(raw_base, raw_target)
        end

        def adapt(raw_base, raw_target)
          output = []
          raw_target.each do |target|
            raw_base.each do |base|
              output << base + "_" + target
            end
          end

          output.map do |pair|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: IndependentReserve::Market::NAME
            )
          end
        end
      end
    end
  end
end
