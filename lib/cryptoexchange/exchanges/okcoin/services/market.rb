module Cryptoexchange::Exchanges
  module Okcoin
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
          "#{Cryptoexchange::Exchanges::Okcoin::Market::API_URL}/ticker.do?symbol=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker = Okcoin::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Okcoin::Market::NAME
          ticker.ask = output['ticker']['sell']
          ticker.bid = output['ticker']['buy']
          ticker.last = output['ticker']['last']
          ticker.high = output['ticker']['high']
          ticker.low = output['ticker']['low']
          ticker.volume = output['ticker']['volume'].to_f
          ticker.timestamp = output['date']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
