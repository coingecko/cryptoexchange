module Cryptoexchange::Exchanges
  module Bitget
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitget::Market::API_URL}/market/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |output|
            base, target = output["symbol"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              market: Bitget::Market::NAME
            )
          end
        end
      end
    end
  end
end
