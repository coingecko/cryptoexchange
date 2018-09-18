module Cryptoexchange::Exchanges
  module Zbg
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
          "#{Cryptoexchange::Exchanges::Zbg::Market::API_URL}/tickers?isUseMarketName=true"
        end

        def adapt_all(output)
          output['datas'].map do |pair|
            base, target = pair[0].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Zbg::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Zbg::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1].to_f)
          ticker.high      = NumericHelper.to_d(output[2].to_f)
          ticker.low       = NumericHelper.to_d(output[3].to_f)
          ticker.bid       = NumericHelper.to_d(output[7].to_f)
          ticker.ask       = NumericHelper.to_d(output[8].to_f)
          ticker.volume    = NumericHelper.to_d(output[4].to_f)
          ticker.change    = NumericHelper.to_d(output[5].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
