module Cryptoexchange::Exchanges
  module Catex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          outputs = []
          (1..3).each do |page_id|
            ticker_output = super(ticker_url(page_id))
            break if ticker_output.empty?
            outputs = outputs + ticker_output["data"]
          end
          adapt_all(outputs)
        end

        def ticker_url(page_id)
          "#{Cryptoexchange::Exchanges::Catex::Market::API_URL}/token/list?page=#{page_id}&pageSize=50"
        end

        def adapt_all(output)
          output.map do |pair_ticker|
            base, target = pair_ticker["pair"].split("/")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Catex::Market::NAME
            )
            adapt(market_pair, pair_ticker)
          end
        end

        def adapt(market_pair, ticker_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Catex::Market::NAME

          ticker.last      = NumericHelper.to_d(ticker_output['priceByBaseCurrency'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(ticker_output['volume24HoursByBaseCurrency']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = ticker_output
          ticker
        end
      end
    end
  end
end
