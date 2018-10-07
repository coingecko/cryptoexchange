module Cryptoexchange::Exchanges
  module Coinpark
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinpark::Market::API_URL}/mdata?cmd=pairList"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            base, target = pair['pair'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinpark::Market::NAME
            )
          end
        end
      end
    end
  end
end
