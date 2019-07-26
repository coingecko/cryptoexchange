module Cryptoexchange::Exchanges
  module Bitci
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
          "#{Cryptoexchange::Exchanges::Bitci::Market::API_URL}/ReturnTicker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair["CoinCode"], pair["CurrencyCode"]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitci::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitci::Market::NAME
          ticker.last      = NumericHelper.to_d(output['Price'])
          ticker.high      = NumericHelper.to_d(output['High24H'])
          ticker.low       = NumericHelper.to_d(output['Low24H'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.volume    = NumericHelper.to_d(output['Volume24H'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
