module Cryptoexchange::Exchanges
  module Coindcx
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
          "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL}/exchange/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            next unless pair["market"].chars.last(3).join == "INR"
            base, target = Coindcx::Market.separate_symbol(pair["market"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Coindcx::Market::NAME
                          )

            adapt(pair, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coindcx::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    = NumericHelper.to_d(output['volume']) / ticker.last
          ticker.change    = NumericHelper.to_d(output['change_24_hour'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])          
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])

          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
