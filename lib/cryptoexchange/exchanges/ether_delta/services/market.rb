require 'bigdecimal'

module Cryptoexchange::Exchanges
  module EtherDelta
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::EtherDelta::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            # format example: ETH_ZRX
            # ETH is the Target, ZRX is the Base
            target, base = pair.split('_')
            # Ignore non-standard BASE
            next if base =~ /\s/ || base =~ /0x/
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: EtherDelta::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          name = "#{market_pair.target}_#{market_pair.base}"
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = EtherDelta::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_s)
          ticker.bid       = NumericHelper.to_d(output['bid'].to_s)
          ticker.ask       = NumericHelper.to_d(output['ask'].to_s)
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'].to_s)
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
