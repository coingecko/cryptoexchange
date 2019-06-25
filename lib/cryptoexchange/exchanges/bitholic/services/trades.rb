module Cryptoexchange::Exchanges
  module Bitholic
    module Services
      class Trades < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch(market_pair)
          output = super(trades_url)
          result = adapt_all(output)
        end

        def adapt_all(output)
          output.map do |pair, payload|
            target, base = pair.split('_')

            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitholic::Market::NAME
            )
            adapt(payload, market_pair)
          end.flatten
        end

        def trades_url
          "#{Cryptoexchange::Exchanges::Bitholic::Market::API_URL}/tradehistory"
        end

        def adapt(payload, market_pair)
          payload.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            id, type, price, amount, time, _total = trade
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = id
            tr.type      = type
            tr.price     = price
            tr.amount    = amount
            tr.timestamp = DateTime.parse(time).to_time.to_i
            tr.payload   = trade
            tr.market    = Bitholic::Market::NAME
            tr
          end
        end
      end
    end
  end
end
