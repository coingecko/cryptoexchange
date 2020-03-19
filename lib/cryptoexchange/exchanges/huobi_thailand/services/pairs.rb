module Cryptoexchange::Exchanges
  module HuobiThailand
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HuobiThailand::Market::API_URL}/market/tickers"

        def fetch
          output = super
          output["data"].map do |ticker|
            base, target = Cryptoexchange::Exchanges::HuobiThailand::Market.separate_symbol(ticker["symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              market: HuobiThailand::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
