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
          ticker = Gatecoin::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = 'gatecoin'
          ticker.last = output['last']
          ticker.bid = output['bid']
          ticker.ask = output['ask']
          ticker.high = output['high']
          ticker.low = output['low']
          ticker.volume = output['volume'] # TODO: Check if it is base denominated?
          ticker.timestamp = output['createDateTime'].to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
