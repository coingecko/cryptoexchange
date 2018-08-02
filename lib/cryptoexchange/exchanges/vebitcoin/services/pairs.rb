module Cryptoexchange::Exchanges
  module Vebitcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vebitcoin::Market::API_URL}/Ticker/All"
        TARGET    = "TRY"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['Code'],
              target: TARGET,
              market: Vebitcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
