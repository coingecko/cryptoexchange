module Cryptoexchange::Exchanges
  module Gobaba
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gobaba::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            symbol = pair['pair'].upcase
            base, target = symbol.split(/(BTC$)+(.*)|(EUR$)+(.*)|(TRY$)+(.*)/)
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Gobaba::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
