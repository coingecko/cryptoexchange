module Cryptoexchange::Exchanges
  module BtcAlpha
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
          "#{Cryptoexchange::Exchanges::BtcAlpha::Market::API_URL}/ticker/?format=json"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['pair'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: BtcAlpha::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BtcAlpha::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.ask       = NumericHelper.to_d(output['sell'].to_f)
          ticker.bid       = NumericHelper.to_d(output['buy'].to_f)
          ticker.volume    = NumericHelper.to_d(output['vol'].to_f)
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
