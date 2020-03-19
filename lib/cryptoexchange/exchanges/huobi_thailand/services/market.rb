module Cryptoexchange::Exchanges
  module HuobiThailand
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
          "#{Cryptoexchange::Exchanges::HuobiThailand::Market::API_URL}/market/tickers"
        end

        def adapt_all(output)
          output["data"].map do |ticker|
            base, target = Cryptoexchange::Exchanges::HuobiThailand::Market.separate_symbol(ticker["symbol"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: HuobiThailand::Market::NAME
                          )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = HuobiThailand::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['amount'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
