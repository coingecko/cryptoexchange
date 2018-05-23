module Cryptoexchange::Exchanges
  module Coinstock
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
          "#{Cryptoexchange::Exchanges::Coinstock::Market::API_URL}/tickers.json"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            separator   = /(USD|BTC|RUR|TLR)\z/i =~ pair
            base        = pair[0..separator - 1]
            target      = pair[separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinstock::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          info = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinstock::Market::NAME
          ticker.ask       = NumericHelper.to_d(info['sell'])
          ticker.bid       = NumericHelper.to_d(info['buy'])
          ticker.last      = NumericHelper.to_d(info['last'])
          ticker.high      = NumericHelper.to_d(info['high'])
          ticker.low       = NumericHelper.to_d(info['low'])
          ticker.volume    = NumericHelper.to_d(info['vol'])
          ticker.change    = NumericHelper.to_d(info['change'])
          ticker.timestamp = NumericHelper.to_d(output['at'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end