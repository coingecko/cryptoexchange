module Cryptoexchange::Exchanges
  module NanuExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::NanuExchange::Market::API_URL}=returnTicker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[1]['currencyPair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: NanuExchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
