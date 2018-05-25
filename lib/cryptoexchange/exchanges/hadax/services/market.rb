module Cryptoexchange::Exchanges
  module Hadax
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker = super(ticker_url(market_pair))
          adapt(ticker, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Hadax::Market::API_URL}/market/detail/merged?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Hadax::Market::NAME
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'ask')[0])
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'bid')[0])
          ticker.last      = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'close'))
          ticker.high      = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'high'))
          ticker.low       = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'low'))
          ticker.volume    = NumericHelper.to_d(HashHelper.dig(output, 'tick', 'amount'))
          ticker.timestamp = output['ts'] / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
