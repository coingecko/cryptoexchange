module Cryptoexchange::Exchanges
  module Therocktrading
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
          "#{Cryptoexchange::Exchanges::Therocktrading::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['result']['tickers'].map do |pair, ticker|
            base, target = pair[0,3], pair[3,6]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Therocktrading::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          market = output
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Therocktrading::Market::NAME
          ticker.ask = NumericHelper.to_d(market['ask'])
          ticker.bid = NumericHelper.to_d(market['bid'])
          ticker.last = NumericHelper.to_d(market['last'])
          ticker.high = NumericHelper.to_d(market['high'])
          ticker.low = NumericHelper.to_d(market['low'])
          ticker.volume = NumericHelper.to_d(market['volume_traded'])
          ticker.timestamp = nil
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
