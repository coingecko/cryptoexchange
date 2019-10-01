module Cryptoexchange::Exchanges
  module Bhex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bhex::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            separator   = /(|AT|BTC|USDT)\z/i =~ pair["symbol"]
            base        = pair["symbol"][0..separator - 1]
            target      = pair["symbol"][separator..-1]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bhex::Market::NAME
            )
          end
        end
      end
    end
  end
end
