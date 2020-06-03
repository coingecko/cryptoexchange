module Cryptoexchange::Exchanges
  module Zg
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zg::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base, target = Zg::Market.separate_symbol(output["symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Zg::Market::NAME
            )
          end
        end
      end
    end
  end
end
