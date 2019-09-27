module Cryptoexchange::Exchanges
  module GmoJapanFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::GmoJapanFutures::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair|
              next if pair['symbol'].include?('_') == false
              base, target = pair['symbol'].split("_")
              inst_id = pair['symbol']
              Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                contract_interval: "perpetual",
                inst_id: inst_id,
                market: GmoJapanFutures::Market::NAME
              )
          end.compact
        end
      end
    end
  end
end
