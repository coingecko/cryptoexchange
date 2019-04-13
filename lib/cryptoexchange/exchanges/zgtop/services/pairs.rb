module Cryptoexchange::Exchanges
  module Zgtop
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zgtop::Market::API_URL}/coins"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base = pair['name']
            target = pair['group']

            Cryptoexchange::Models::MarketPair.new(
              inst_id: pair['symbol'],
              base: base,
              target: target,
              market: Zgtop::Market::NAME
            )
          end
        end
      end
    end
  end
end
