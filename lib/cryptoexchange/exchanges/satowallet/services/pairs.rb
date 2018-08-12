module Cryptoexchange::Exchanges
  module Satowallet
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Satowallet::Market::API_URL}/?__wallets_exchange_action=get_market_summaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['market_summaries'].map do |pair, _ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Satowallet::Market::NAME
            )
          end
        end
      end
    end
  end
end
