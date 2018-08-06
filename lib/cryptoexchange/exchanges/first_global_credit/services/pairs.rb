module Cryptoexchange::Exchanges
  module FirstGlobalCredit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::FirstGlobalCredit::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |out|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: out['base_currency'],
                              market: out['currency_pair'],
                              target: out['float_currency'],
                              second_market: FirstGlobalCredit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
