module Cryptoexchange::Exchanges
  module LocalBitcoins
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::LocalBitcoins::Market::API_URL}/bitcoinaverage/ticker-all-currencies/"

        def fetch
          adapt(super)
        end

        def adapt(output)
          market_pairs = []
          output.each_key do |key|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: 'BTC',
                              target: key,
                              market: LocalBitcoins::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
