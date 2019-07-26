module Cryptoexchange::Exchanges
  module CoinflexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinflex_futures'
      API_URL = 'https://webapi.coinflex.com'

      def self.trade_page_url(args={})
        "https://coinflex-preview.trade.tt/live/preview"
      end

      def self.assign_inst_id(market_pair)
        coins_list ||= JSON.parse(HTTP.get("#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/assets/"))
        base_id = coins_list.select {|s| s["name"].to_s.casecmp("#{market_pair.base}#{market_pair.contract_interval}".upcase) == 0 }.first["id"]
        target_id = coins_list.select {|s| s["name"].to_s.casecmp("#{market_pair.target}#{market_pair.contract_interval}".upcase) == 0 }.first["id"]

        Cryptoexchange::Models::MarketPair.new(
          base: market_pair.base,
          target: market_pair.target,
          inst_id: "#{base_id}:#{target_id}",
          contract_interval: market_pair.contract_interval,
          market: Cryptoexchange::Exchanges::CoinflexFutures::Market::NAME
        )
      end      
    end
  end
end
