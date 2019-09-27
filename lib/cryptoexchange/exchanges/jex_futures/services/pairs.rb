module Cryptoexchange::Exchanges
  module JexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Jex::Market::API_URL}/exchangeInfo"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output = output['contractSymbols']
          output.map do |pair|
            base, target = pair['baseAsset'], pair['quoteAsset']
            inst_id = pair['symbol']
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              contract_interval: 'perpetual',
              inst_id: inst_id,
              market: JexFutures::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
