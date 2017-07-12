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
          output = output['ticker']
          ticker = BitcoinIndonesia::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = BitcoinIndonesia::Market::NAME
          ticker.bid = output['buy']
          ticker.ask = output['sell']
          ticker.last = output['last']
          ticker.high = output['high']
          ticker.low = output['low']
          ticker.volume = output["vol_#{ticker.base.downcase}"].to_f
          ticker.timestamp = output['server_time']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
