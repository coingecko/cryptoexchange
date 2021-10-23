module Cryptoexchange::Exchanges
  module ZbgFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::ZbgFutures::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output['datas']['ticker'].each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: pair['symbol'],
                              contract_interval: "perpetual",
                              market: ZbgFutures::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
