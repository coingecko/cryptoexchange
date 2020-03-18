module Cryptoexchange::Exchanges
  module CoinflexFutures
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
          "#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/tickers/"
        end

        def adapt_all(output)
          output.map do |ticker|
            if ticker["name"] != ticker["spot_name"]
              base, target = ticker["spot_name"].split("/")
              inst_id = ticker["name"]

              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: inst_id,
                              market: Coinflex::Market::NAME
                            )
              adapt(ticker, market_pair)
            end
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.market    = CoinflexFutures::Market::NAME
          ticker.inst_id    = market_pair.inst_id
          ticker.bid       = output['bid'].to_f / 10000.0
          ticker.ask       = output['ask'].to_f / 10000.0
          ticker.last      = output['last'].to_f / 10000.0
          ticker.high      = output['high'].to_f / 10000.0
          ticker.low       = output['low'].to_f / 10000.0
          ticker.volume    = output['volume'].to_f / 10000.0
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
