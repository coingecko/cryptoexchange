module Cryptoexchange::Exchanges
  module KrakenFutures
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
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['tickers'].map do |output|
            if output.key?("pair")
              base, target = output["pair"].split(":")
              market_pair  = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: KrakenFutures::Market::NAME,
                contract_interval: output["tag"],
                inst_id: output["symbol"],
              )
              adapt(market_pair, output)              
            end
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id   = market_pair.inst_id
          ticker.market    = KrakenFutures::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['vol24h']) / ticker.last
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
