module Cryptoexchange::Exchanges
  module Cryptaldash
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptaldash::Market::API_URL}/pubticker/all"

        def fetch
          output = super
          market_pairs = []
          output['market_summary'].each do |pair|
            symbol = pair['symbol'].upcase
            base, target = symbol.split(/(BTCONE$)+(.*)|(BTC$)+(.*)|(ETH$)+(.*)|(USDT$)+(.*)|(CRD$)+(.*)|(XEM$)+(.*)/)
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Cryptaldash::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
