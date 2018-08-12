module Cryptoexchange::Exchanges
  module Satowallet
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Satowallet::Market::API_URL}/?__wallets_exchange_action=get_market_summaries"
        end

        def adapt_all(output)
          output['market_summaries'].map do |pair, ticker|
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Satowallet::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Satowallet::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['min_ask'])
          ticker.bid       = NumericHelper.to_d(output['max_bid'])
          ticker.volume    = NumericHelper.to_d(output['trade_volume_quote_24'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
