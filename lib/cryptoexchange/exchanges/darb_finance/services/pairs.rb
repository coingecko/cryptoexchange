module Cryptoexchange::Exchanges
  module DarbFinance
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DarbFinance::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          output.map do |output|
            base, target = output['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: DarbFinance::Market::NAME
            )
          end
        end
      end
    end
  end
end
