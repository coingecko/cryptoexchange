module Cryptoexchange::Exchanges
  module Btcnext
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
          "#{Cryptoexchange::Exchanges::Btcnext::Market::API_URL}/b2trade/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            separator = /(BTC|USDT|ETH)\z/ =~ pair['Instrument']

            next if separator.nil?

            base   = pair['Instrument'][0..separator - 1]
            target = pair['Instrument'][separator..-1]

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcnext::Market::NAME
            )

            adapt(pair, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Btcnext::Market::NAME
          ticker.ask = NumericHelper.to_d(output['BestOffer'])
          ticker.bid = NumericHelper.to_d(output['BestBid'])
          ticker.last = NumericHelper.to_d(output['LastTradedPx'])
          ticker.high = NumericHelper.to_d(output['SessionHigh'])
          ticker.low = NumericHelper.to_d(output['SessionLow'])
          ticker.volume = NumericHelper.to_d(output['Rolling24HrVolume'])
          ticker.change = NumericHelper.to_d(output['Rolling24HrPxChange'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
