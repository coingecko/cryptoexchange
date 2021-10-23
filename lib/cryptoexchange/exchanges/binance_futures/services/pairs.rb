module Cryptoexchange::Exchanges
  module BinanceFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PERPETUAL_PAIRS_URL = "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/exchangeInfo"
        FUTURES_PAIRS_URL = "#{Cryptoexchange::Exchanges::BinanceFutures::Market::FUTURES_API_URL}/exchangeInfo"

        def fetch
          perpetual_output = fetch_via_api(PERPETUAL_PAIRS_URL)
          futures_output = fetch_via_api(FUTURES_PAIRS_URL)
          adapt(perpetual_output, :perpetual) + adapt(futures_output, :futures)
        end

        def adapt(output, type)
          output["symbols"].map do |pair|

            if type == :perpetual
              next if pair["status"] != "TRADING"
            elsif type == :futures
              next if pair["contractStatus"] != "TRADING"
            end

            base = pair["baseAsset"]
            target = pair["quoteAsset"]
            next unless base && target

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: BinanceFutures::Market::NAME,
              contract_interval: type.to_s,
              inst_id: pair["symbol"]
            )
          end.compact
        end
      end
    end
  end
end
