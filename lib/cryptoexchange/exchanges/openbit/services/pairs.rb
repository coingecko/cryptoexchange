module Cryptoexchange::Exchanges
  module Openbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Openbit::Market::API_URL}/Mapi/Index/marketInfo"

        def fetch
          output = super
          market_pairs = []
          output['data']['market'].each do |pair|
            raw_pair = pair['name'].match(/(\(.*)\)/).to_s
            base, target = raw_pair.delete('()').split('/')
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Openbit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
