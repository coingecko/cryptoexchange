module Cryptoexchange::Exchanges
  module Eterbase
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
          "#{Cryptoexchange::Exchanges::Eterbase::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          client = Cryptoexchange::Client.new
          pairs = client.pairs('eterbase')

          output.map do |ticker|
            pair = pairs.find {|i| i.inst_id == ticker['marketId'] }
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: pair.base,
              target: pair.target,
              market: Eterbase::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Eterbase::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low      = NumericHelper.to_d(output['low'])
          ticker.volume   = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
