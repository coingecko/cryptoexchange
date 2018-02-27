module Cryptoexchange::Exchanges
  module Coinbene
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
          "#{Cryptoexchange::Exchanges::Coinbene::Market::API_URL}/market/ticker?symbol=all"
        end

        def adapt_all(output)
          output['ticker'].map do |ticker|
            separator = /(USDT|BTC|ETH)\z/ =~ ticker['symbol']
            base = ticker['symbol'][0..separator - 1]
            target   = ticker['symbol'][separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Coinbene::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinbene::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['24hrHigh'])
          ticker.low       = NumericHelper.to_d(output['24hrLow'])
          ticker.volume    = NumericHelper.to_d(output['24hrVol'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
