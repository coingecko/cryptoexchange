module Cryptoexchange::Exchanges
  module Localbitcoins
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
          "#{Cryptoexchange::Exchanges::Localbitcoins::Market::API_URL}/bitcoinaverage/ticker-all-currencies/"
        end

        def adapt_all(output)
          output.map do |target, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: "BTC",
                            target: target,
                            market: Localbitcoins::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Localbitcoins::Market::NAME
          ticker.last      = NumericHelper.to_d(output['avg_12h'])
          ticker.volume    = NumericHelper.to_d(output['volume_btc'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
