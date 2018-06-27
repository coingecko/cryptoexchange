module Cryptoexchange::Exchanges
  module Coinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinex::Market::API_URL}/market/list"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            separator = Cryptoexchange::Exchanges::Coinex::Market::SEPARATOR_REGEX =~ pair
            next unless separator
            base = pair[0..separator - 1]
            target = pair[separator..-1]
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Coinex::Market::NAME
            })
          end
        end
      end
    end
  end
end
