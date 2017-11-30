module Cryptoexchange::Exchanges
  module LocalBitcoins
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
          "#{Cryptoexchange::Exchanges::LocalBitcoins::Market::API_URL}/bitcoinaverage/ticker-all-currencies/"
        end

        def adapt_all(output)
          tickers = []
          output.each do |key, value|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: 'BTC',
              target: key,
              market: LocalBitcoins::Market::NAME
            )
            tickers << adapt(value, market_pair)
          end
          tickers
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = LocalBitcoins::Market::NAME
          ticker.volume    = NumericHelper.to_d(output['volume_btc'])
          ticker.last      = NumericHelper.to_d(output['rates']['last'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
