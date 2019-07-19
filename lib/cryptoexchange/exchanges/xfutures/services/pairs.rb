module Cryptoexchange::Exchanges
  module Xfutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Xfutures::Market::API_URL}/spot/v3/instruments/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair["instrument_id"].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: pair["instrument_id"],
                              market: Xfutures::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
