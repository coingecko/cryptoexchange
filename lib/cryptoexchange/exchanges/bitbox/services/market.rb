module Cryptoexchange::Exchanges
  module Bitbox
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
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/market/prices"
        end

        def adapt_all(output)
          output["responseData"].map do |output|
            base = output["b"] == "LINK" ? "LN" : output["b"]
            target = output["a"] == "LINK" ? "LN" : output["a"]

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bitbox::Market::NAME
                          )
            adapt(market_pair, output)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitbox::Market::NAME
          ticker.last = NumericHelper.to_d(output['g'])
          ticker.low = NumericHelper.to_d(output['f'])
          ticker.high = NumericHelper.to_d(output['e'])
          ticker.change = NumericHelper.to_d(output['i'])
          ticker.volume = NumericHelper.to_d(output['h'])/NumericHelper.to_d(output['g'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
