module Cryptoexchange::Exchanges
  module Coindcx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL}/exchange/v1/markets_details"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base = output['base_currency_short_name']
            target = output['target_currency_short_name']
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Coindcx::Market::NAME
            })
          end
        end
      end
    end
  end
end
