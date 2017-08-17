module Cryptoexchange::Exchanges
  module Jubi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Jubi::Market::API_URL}/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          default_target = 'CNY'
          output.keys.map do |base|
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: default_target,
              market: Jubi::Market::NAME
            })
          end
        end
      end
    end
  end
end
