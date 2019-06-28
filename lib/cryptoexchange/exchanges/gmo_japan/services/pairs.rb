module Cryptoexchange::Exchanges
  module GmoJapan
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::GmoJapan::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair|
            # Exclude _ as BTC_JPY with _JPY refers to leverage trading
            next if pair['symbol'].include?('_')
            base, target = pair['symbol'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: "JPY",
              market: GmoJapan::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
