module Cryptoexchange::Exchanges
  module Localbitcoins
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Localbitcoins::Market::API_URL}/bitcoinaverage/ticker-all-currencies/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |target, pair|
            base = "BTC"
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Localbitcoins::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
