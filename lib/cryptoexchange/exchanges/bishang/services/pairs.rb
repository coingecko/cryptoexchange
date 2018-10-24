module Cryptoexchange::Exchanges
  module Bishang
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bishang::Market::API_URL}/allticker"

        def fetch
          output = super
          market_pairs = []
          output['ticker'].each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Bishang::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
