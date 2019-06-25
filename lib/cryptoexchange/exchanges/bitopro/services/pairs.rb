module Cryptoexchange::Exchanges
  module Bitopro
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitopro::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          market_pairs = []
          pairs["data"].each do |ticker, value|
            base, target = ticker["pair"].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitopro::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
