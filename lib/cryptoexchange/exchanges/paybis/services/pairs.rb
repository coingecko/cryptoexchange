module Cryptoexchange::Exchanges
  module Paybis
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paybis::Market::API_URL}/rates/json/"

        def fetch
          output = super
          market_pairs = []
          output['item'].each do |pair|
            base = pair['from'].split(/(USD$)+(.*)|(EUR$)+(.*)|(RUB$)+(.*)|(GBP$)+(.*)|(BTC$)+(.*)|(LTC$)+(.*)|(BCH$)+(.*)|(ETH$)+(.*)|(XRP$)+(.*)/).last
            target = pair['to'].split(/(USD$)+(.*)|(EUR$)+(.*)|(RUB$)+(.*)|(GBP$)+(.*)|(BTC$)+(.*)|(LTC$)+(.*)|(BCH$)+(.*)|(ETH$)+(.*)|(XRP$)+(.*)/).last
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Paybis::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
