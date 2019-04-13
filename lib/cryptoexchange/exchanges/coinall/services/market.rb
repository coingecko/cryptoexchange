module Cryptoexchange::Exchanges
  module Coinall
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
          "#{Cryptoexchange::Exchanges::Coinall::Market::API_URL}/spot/v3/products/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['product_id'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinall::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinall::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high_24h'].to_f)
          ticker.low       = NumericHelper.to_d(output['low_24h'].to_f)
          ticker.bid       = NumericHelper.to_d(output['best_bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['best_ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['base_volume_24h'].to_f)
          ticker.timestamp = DateTime.parse(output['timestamp']).to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
