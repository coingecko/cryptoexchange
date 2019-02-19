module Cryptoexchange::Exchanges
  module Idax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Idax::Market::API_URL}/ticker"

        def fetch
          output = super
          output['ticker'].map do |output|
            base, target = output['pair'].split('_')
            Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Idax::Market::NAME
            )
          end
        end
      end
    end
  end
end

