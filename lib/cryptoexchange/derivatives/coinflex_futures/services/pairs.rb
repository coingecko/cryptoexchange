module Cryptoexchange::Exchanges
  module CoinflexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/tickers/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          coins_list = JSON.parse(HTTP.get("#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/assets/"))
          output.map do |pair|
            base = coins_list.select {|s| s["id"].to_s.casecmp(pair["base"].to_s) == 0 }.first
            target = coins_list.select {|s| s["id"].to_s.casecmp(pair["counter"].to_s) == 0 }.first
            if base.key?("spot") && target.key?("spot")
              base = base["name"]
              target = target["name"]

              Cryptoexchange::Models::MarketPair.new(
                base: base[0..-4],
                target: target[0..-4],
                inst_id: "#{pair["base"]}:#{pair["counter"]}",
                contract_interval: base[-3..-1],
                market: CoinflexFutures::Market::NAME
              )
            end
          end.compact
        end
      end
    end
  end
end
