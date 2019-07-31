module Cryptoexchange::Exchanges
  module DoveWallet
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'][0],market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DoveWallet::Market::API_URL}/getmarketsummary?market=#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = DoveWallet::Market::NAME
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.volume    = NumericHelper.to_d(output['Volume']) / ticker.last
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
