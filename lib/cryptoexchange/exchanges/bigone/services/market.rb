module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['market_id'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bigone::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bigone::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'bid', 'price'))
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'ask', 'price'))
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.change    = NumericHelper.to_d(output['daily_change_perc'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
