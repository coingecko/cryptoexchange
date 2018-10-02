module Cryptoexchange::Exchanges
  module Blockonix
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Blockonix::Market::API_URL}/symbols/symbol/"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['quoteCurrencyName'],
                              target: pair['baseCurrencyName'],
                              inst_id: "baseAddress=#{pair['baseAddress']}&quoteAddress=#{pair['quoteAddress']}",
                              market: Blockonix::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
