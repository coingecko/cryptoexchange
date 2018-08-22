module Cryptoexchange::Exchanges
  module Cointiger
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end
        TARGETS = ['BTC', 'ETH', 'BITCNY', 'USDT']

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cointiger::Market::MARKET_URL}"
        end

        def adapt_all(output)
          output.map do |ticker|
            symbol = ticker[0]
            base, target = strip_pairs(symbol)
                market_pair = Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Cointiger::Market::NAME
                              )
                adapt(ticker[1], market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cointiger::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end

        def strip_pairs(pair_symbol)
          #Match last 3 or 4 if it hits target
          last_6 = pair_symbol[-6..-1]
          last_4 = pair_symbol[-4..-1]
          last_3 = pair_symbol[-3..-1]

          if TARGETS.include? last_6
            base = pair_symbol[0..-7]
            target = last_6
          elsif
            TARGETS.include? last_4
            base = pair_symbol[0..-5]
            target = last_4
          elsif TARGETS.include? last_3
            base = pair_symbol[0..-4]
            target = last_3
          end

          [base, target]
        end
      end
    end
  end
end
