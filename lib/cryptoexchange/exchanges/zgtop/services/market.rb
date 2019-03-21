module Cryptoexchange::Exchanges
  module Zgtop
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
          "#{Cryptoexchange::Exchanges::Zgtop::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          pairs = Cryptoexchange::Exchanges::Zgtop::Services::Pairs.new.fetch

          output['data'].map do |output|
            inst_id = output['symbol']
            pair = pairs.detect { |pair| pair.inst_id == inst_id }

            next if pair.nil?

            base = pair.base
            target = pair.target

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Zgtop::Market::NAME
                          )
            adapt(output, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Zgtop::Market::NAME

          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
