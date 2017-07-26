module Cryptoexchange::Exchanges
  module Bter
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bter::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair.upcase.split('_')

            Bter::Models::MarketPair.new({
              base: base,
              target: target,
              market: Bter::Market::NAME
            })
          end
        end
      end
    end
  end
end
