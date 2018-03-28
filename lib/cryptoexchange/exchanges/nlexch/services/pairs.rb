module Cryptoexchange::Exchanges
  module Nlexch
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nlexch::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair['name'].split('/')

            # Workaround for bad unicode {"id":"1tcbtc","name":"LTC¦/BTC"}
            target.downcase!
            base = pair['id'].match(/(.+)#{target}/)[1]

            market_pair.base = base
            market_pair.target = target
            market_pair.market = Nlexch::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
