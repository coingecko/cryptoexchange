module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          exchangeAddress = market_pair.inst_id
          pairs = Cryptoexchange::Exchanges::Uniswap::Services::Pairs.new.fetch
          pair = pairs.select { |s| s.base == market_pair.base }.first
          exchangeAddress = pair.inst_id
          "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}/ticker?exchangeAddress=#{exchangeAddress}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Uniswap::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastTradePrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = (NumericHelper.to_d(output['tradeVolume']) / 10**18) * ticker.last
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
