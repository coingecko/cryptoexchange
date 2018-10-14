module Cryptoexchange::Exchanges
  module Exchangeassets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exchangeassets::Market::API_URL}/ticker/"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Exchangeassets::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
