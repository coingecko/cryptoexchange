module Cryptoexchange::Exchanges
  module Satoexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'satoexchange'
      API_URL = 'https://www.satoexchange.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.satoexchange.com/market/#{args[:base]}/#{args[:target]}/"
      end

      def self.assign_inst_id(market_pair)
        pairs_url = "#{Cryptoexchange::Exchanges::Satoexchange::Market::API_URL}/get_markets/"
        output = Cryptoexchange::Cache.ticker_cache.fetch(pairs_url) do
          HTTP.timeout(15).headers(accept: 'application/json').follow.get(pairs_url).parse(:json)
        end

        mp_raw = output["markets"].find do |market_pair_raw|
          base, target = market_pair_raw["slug"].split("/")
          market_pair.base == base && market_pair.target == target
        end

        Cryptoexchange::Models::MarketPair.new(
          base: market_pair.base,
          target: market_pair.target,
          inst_id: mp_raw["id"],
          market: Cryptoexchange::Exchanges::Satoexchange::Market::NAME
        )
      end
    end
  end
end
