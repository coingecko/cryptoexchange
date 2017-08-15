module Cryptoexchange::Exchanges
  module Yunbi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Yunbi::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair['name'].split('/')

            # Workaround for bad unicode {"id":"1stcny","name":"1SÅ¦/CNY"}
            target.downcase!
            base = pair['id'].match(/(.+)#{target}/)[1]

            market_pair.base = base
            market_pair.target = target
            market_pair.market = Yunbi::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
