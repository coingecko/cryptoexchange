module Cryptoexchange::Exchanges
  module Gdac
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gdac::Market::API_URL}/public/marketsummaries"

        def fetch
          output = super()
          market_pairs = []
          pairs = output['result'].map { |r| r["marketName"].split("-") }
          pairs.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair.first,
                              target: pair.last,
                              market: Gdac::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
