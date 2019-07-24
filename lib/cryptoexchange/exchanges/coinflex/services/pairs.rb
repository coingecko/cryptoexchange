module Cryptoexchange::Exchanges
  module Coinflex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinflex::Market::API_URL}/tickers/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          coins_list = JSON.parse(HTTP.get("#{Cryptoexchange::Exchanges::Coinflex::Market::API_URL}/assets/"))
          output.map do |pair|
            base = coins_list.select {|s| s["id"].to_s.casecmp(pair["base"].to_s) == 0 }.first["name"]
            target = coins_list.select {|s| s["id"].to_s.casecmp(pair["counter"].to_s) == 0 }.first["name"]
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: "#{pair["base"]}:#{pair["counter"]}",
              market: Coinflex::Market::NAME
            )
          end
        end
      end
    end
  end
end
