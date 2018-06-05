module Cryptoexchange::Exchanges
  module Kryptono
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Kryptono::Market::MARKET_API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            base, target = pair['MarketName'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Kryptono::Market::NAME
            )
          end
        end
      end
    end
  end
end
