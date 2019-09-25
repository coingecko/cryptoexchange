module Cryptoexchange::Exchanges
  module BitforexFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output["data"])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BitforexFutures::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |inst_id, ticker|
            type, target, base = inst_id.split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            inst_id: inst_id,
                            contract_interval: 'perpetual',
                            market: GateFutures::Market::NAME
                          )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.market    = BitforexFutures::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['productvol']), ticker.last)
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
