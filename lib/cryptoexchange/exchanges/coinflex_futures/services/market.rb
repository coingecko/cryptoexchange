module Cryptoexchange::Exchanges
  module CoinflexFutures
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
          "#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/tickers/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.market    = CoinflexFutures::Market::NAME
          ticker.bid       = output['bid'].to_f / 10000
          ticker.ask       = output['ask'].to_f / 10000
          ticker.last      = output['last'].to_f / 10000
          ticker.high      = output['high'].to_f / 10000
          ticker.low       = output['low'].to_f / 10000
          ticker.volume    = output['volume'].to_f / 10000
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
