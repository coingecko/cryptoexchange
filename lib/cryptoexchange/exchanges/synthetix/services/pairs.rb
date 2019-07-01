module Cryptoexchange::Exchanges
  module Synthetix
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Synthetix::Market::API_URL}/pairs/crypto"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
              target, base = pair.split('-')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Synthetix::Market::NAME
                              )
          end
          market_pairs
        end
      end
    end
  end
end
