module Cryptoexchange::Exchanges
  module Vebitcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vebitcoin::Market::API_URL}/app/api/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['SourceCoinCode'],
              target: pair['TargetCoinCode'],
              market: Vebitcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
