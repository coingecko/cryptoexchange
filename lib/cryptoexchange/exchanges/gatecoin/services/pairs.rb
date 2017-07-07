module Cryptoexchange::Exchanges
  module Gatecoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        MARKET = Gatecoin::Market
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gatecoin::Market::API_URL}/Public/LiveTickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['tickers']
          market_pairs = []
          pairs.each do |pair|
            currency_pair = pair['currencyPair']
            base = currency_pair[0..2]
            target = currency_pair[3..-1]

            market_pair = Gatecoin::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = MARKET::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
