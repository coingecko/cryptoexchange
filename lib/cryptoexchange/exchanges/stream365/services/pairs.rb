module Cryptoexchange::Exchanges
  module Stream365
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Stream365::Market::API_URL}/api/pairing/"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[1]['ticker'],
                              target: pair[1]['market'],
                              inst_id: pair[1]['pairing_id'],
                              market: Stream365::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
