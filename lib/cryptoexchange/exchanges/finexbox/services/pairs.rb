module Cryptoexchange::Exchanges
  module Finexbox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Finexbox::Market::API_URL}/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            base, target = pair['market'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Finexbox::Market::NAME
            )
          end
        end
      end
    end
  end
end
