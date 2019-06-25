module Cryptoexchange::Exchanges
  module BitsBlockchain
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "https://www.bitsblockchain.net/moon/v1/market/tick/ANX/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          pair = "#{market_pair.base}#{market_pair.target}"
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = BitsBlockchain::Market::NAME
          ticker.ask = NumericHelper.to_d(output[0][pair]['ask'])
          ticker.bid = NumericHelper.to_d(output[0][pair]['bid'])
          ticker.last = NumericHelper.to_d(output[0][pair]['last'])
          ticker.high = NumericHelper.to_d(output[0][pair]['high'])
          ticker.low = NumericHelper.to_d(output[0][pair]['low'])
          ticker.volume = NumericHelper.to_d(output[0][pair]['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
