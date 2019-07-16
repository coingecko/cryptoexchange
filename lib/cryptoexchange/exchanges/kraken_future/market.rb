module Cryptoexchange::Exchanges
  module KrakenFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'kraken_futures'
      API_URL = 'https://www.cryptofacilities.com/derivatives/api/v3'

      def self.trade_page_url(args={})
        "https://futures.kraken.com/dashboard"
      end

      def self.assign_inst_id(market_pair)
        pairs_url = "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
        output = Cryptoexchange::Cache.ticker_cache.fetch(pairs_url) do
          HTTP.timeout(15).headers(accept: 'application/json').follow.get(pairs_url).parse(:json)
        end

        mp_raw = output["tickers"].find do |market_pair_raw|
          base, target = market_pair_raw["pair"].split(":")
          market_pair.base == base && market_pair.target == target
        end
        
        Cryptoexchange::Models::MarketPair.new(
          base: market_pair.base,
          target: market_pair.target,
          inst_id: mp_raw["symbol"],
          market: Cryptoexchange::Exchanges::KrakenFutures::Market::NAME
        )
      end
    end
  end
end
