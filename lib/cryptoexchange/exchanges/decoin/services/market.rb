module Cryptoexchange::Exchanges
  module Decoin
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
          "#{Cryptoexchange::Exchanges::Decoin::Market::API_URL}/market/get-ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['Name'].split("/")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: Decoin::Market::NAME
                          )

            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Decoin::Market::NAME

          ticker.last      = NumericHelper.to_d(output['LastPrice'])
          ticker.volume    = NumericHelper.to_d(output['Volume']) / ticker.last
          ticker.bid       = NumericHelper.to_d(output['BidPrice'])
          ticker.ask       = NumericHelper.to_d(output['AskPrice'])
          ticker.low       = NumericHelper.to_d(output['LowPrice'])
          ticker.high      = NumericHelper.to_d(output['HighPrice'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
