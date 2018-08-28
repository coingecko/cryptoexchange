module Cryptoexchange::Exchanges
  module Bitlish
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitlish::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            symbol = pair[0].upcase
            base, target = symbol.split(/(BTC$)+|(ETH$)+(.*)|(USDT$)+(.*)|(EUR$)+(.*)|(GBP$)+(.*)|(RUB$)+(.*)|(USD$)+(.*)|(JPY$)+(.*)|(TDT$)+(.*)/)
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitlish::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
