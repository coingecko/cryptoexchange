module Cryptoexchange::Exchanges
  module UpbitIndonesia
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        GROUP = ["IDR", "BTC", "ETH", "USDT"]

        def fetch
          output = get_pairs
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: UpbitIndonesia::Market::NAME
            )
          end
        end

        private

        def get_pairs
          pairs = []
          GROUP.each do |g|
            output = JSON.parse(HTTP.get("https://crix-api-sg-tv.upbit.com/v1/crix/tradingview/symbol_info?group=#{g}&region=id"))
            output["description"].each do |o|
              pairs << o
            end
          end
          pairs
        end
      end
    end
  end
end
