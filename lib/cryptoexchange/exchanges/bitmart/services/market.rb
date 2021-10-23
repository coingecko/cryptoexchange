module Cryptoexchange::Exchanges
  module Bitmart
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
          "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair["symbol_id"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitmart::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitmart::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask_1'])
          ticker.bid       = NumericHelper.to_d(output['bid_1'])
          ticker.high      = NumericHelper.to_d(output['highest_price'])
          ticker.low       = NumericHelper.to_d(output['lowest_price'])
          ticker.last      = NumericHelper.to_d(output['current_price'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
