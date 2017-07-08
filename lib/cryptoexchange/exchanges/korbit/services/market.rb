module Cryptoexchange::Exchanges
  module Korbit
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
          "#{Cryptoexchange::Exchanges::Korbit::Market::API_URL}/ticker/detailed?currency_pair=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker = Korbit::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Korbit::Market::NAME
          ticker.ask = output['ask']
          ticker.bid = output['bid']
          ticker.last = output['last']
          ticker.high = output['high']
          ticker.low = output['low']
          ticker.volume = output['volume'].to_f
          ticker.timestamp = output['timestamp']/1000
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
