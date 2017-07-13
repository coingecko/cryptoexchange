module Cryptoexchange::Exchanges
  module BitcoinIndonesia
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BitcoinIndonesia::Market::API_URL}/#{base}_#{target}/ticker"
        end

        def adapt(output, market_pair)
          output           = output['ticker']
          ticker           = BitcoinIndonesia::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitcoinIndonesia::Market::NAME
          ticker.bid       = output['buy'] ? BigDecimal.new(output['buy'].to_s) : nil
          ticker.ask       = output['sell'] ? BigDecimal.new(output['sell'].to_s) : nil
          ticker.last      = output['last'] ? BigDecimal.new(output['last'].to_s) : nil
          ticker.high      = output['high'] ? BigDecimal.new(output['high'].to_s) : nil
          ticker.low       = output['low'] ? BigDecimal.new(output['low'].to_s) : nil
          ticker.volume    = output["vol_#{ticker.base.downcase}"] ? BigDecimal.new(output["vol_#{ticker.base.downcase}"].to_s) : nil
          ticker.timestamp = output['server_time'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
