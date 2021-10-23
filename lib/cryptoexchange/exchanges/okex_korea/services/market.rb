module Cryptoexchange::Exchanges
  module OkexKorea
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
          "#{Cryptoexchange::Exchanges::OkexKorea::Market::API_URL}/instruments/ticker"
        end


        def adapt_all(output)
          output.map do |pair|
            base, target = pair['product_id'].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: OkexKorea::Market::NAME
                          )
            adapt(pair, market_pair)
          end  
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = OkexKorea::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high_24h'])
          ticker.low       = NumericHelper.to_d(output['low_24h'])
          ticker.volume    = NumericHelper.to_d(output['base_volume_24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
