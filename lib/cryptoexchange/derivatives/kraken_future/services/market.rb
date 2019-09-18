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
          instruments = super(instruments_url)
          output = super(ticker_url)
          adapt_all(output, instruments)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
        end

        def instruments_url
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/instruments"
        end

        def adapt_all(output, instruments)
          output['tickers'].map do |output|
            if output.key?("pair")
              base, target = output["pair"].split(":")
              instrument = instruments["instruments"].select { |i| i['symbol'] == output['symbol']}.first
              market_pair  = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: KrakenFutures::Market::NAME,
                inst_id: output["symbol"]
              )
              adapt(market_pair, output, instrument)
            end
          end.compact
        end

        def adapt(market_pair, output, instrument)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = output["symbol"]
          ticker.market    = KrakenFutures::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['vol24h']) / ticker.last

          ticker.start_timestamp = nil
          ticker.expire_timestamp = DateTime.parse(instrument['lastTradingTime']).to_time.to_i if instrument['lastTradingTime']

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
