module Cryptoexchange::Exchanges
  module Gatecoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Gatecoin::Market::API_URL}/Public/LiveTickers"
        end

        def adapt_all(output)
          output['tickers'].map do |ticker|
            currency_pair = ticker['currencyPair']
            market_pair = Cryptoexchange::Exchanges::Gatecoin::Models::MarketPair.new(
                            base: currency_pair[0..2],
                            target: currency_pair[3..-1],
                            market: Gatecoin::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Gatecoin::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = 'gatecoin'
          ticker.last      = output['last'] ? BigDecimal.new(output['last'].to_s) : nil
          ticker.bid       = output['bid'] ? BigDecimal.new(output['bid'].to_s) : nil
          ticker.ask       = output['ask'] ? BigDecimal.new(output['ask'].to_s) : nil
          ticker.high      = output['high'] ? BigDecimal.new(output['high'].to_s) : nil
          ticker.low       = output['low'] ? BigDecimal.new(output['low'].to_s) : nil
          ticker.volume    = output['volume'] ? BigDecimal.new(output['volume'].to_s) : nil # TODO: Check if it is base denominated?
          ticker.timestamp = output['createDateTime'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
