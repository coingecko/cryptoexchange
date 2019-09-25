module Cryptoexchange::Exchanges
  module GmoJapanFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all output
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::GmoJapanFutures::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output["data"].map do |ticker|
            next if ticker['symbol'].include?('_') == false
            base, target = ticker['symbol'].split("_")
            inst_id = ticker['symbol']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: inst_id,
              market: GmoJapanFutures::Market::NAME
            )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = GmoJapanFutures::Market::NAME
          ticker.inst_id   = market_pair.inst_id
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          # this is their typo
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
