module Cryptoexchange::Exchanges
  module SafeTrade
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
          "#{Cryptoexchange::Exchanges::SafeTrade::Market::API_URL}/v2/tickers"
        end

        def adapt_all(output)
          pairs = Cryptoexchange::Exchanges::SafeTrade::Services::Pairs.new.fetch

          output.map do |pair_id, ticker|
            market_pair = pairs.find{ |p| p.inst_id == pair_id }
            adapt(market_pair, ticker) if market_pair
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = SafeTrade::Market::NAME
          ticker.last      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'last'))
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'sell'))
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'buy'))
          ticker.volume    = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'vol'))
          ticker.high      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'high'))
          ticker.low       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'low'))
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
