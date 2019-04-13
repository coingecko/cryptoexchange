module Cryptoexchange::Exchanges
  module Dakuce
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dakuce::Market::API_URL}/getmarketsummaries"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: pair['id'],
                              market: Dakuce::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
