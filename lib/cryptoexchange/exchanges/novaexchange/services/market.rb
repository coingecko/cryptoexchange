require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Novaexchange
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
          name = "#{market_pair.base}_#{market_pair.target}"

          "#{Cryptoexchange::Exchanges::Novaexchange::Market::API_URL}/market/info/#{name}/"
        end

        def adapt(output, market_pair)
          market = output['markets'][0]

          ticker = Novaexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Novaexchange::Market::NAME
          ticker.last = BigDecimal.new(market['last_price'])
          ticker.bid = BigDecimal.new(market['bid'])
          ticker.ask = BigDecimal.new(market['ask'])
          ticker.high = BigDecimal.new(market['high24h'])
          ticker.low = BigDecimal.new(market['low24h'])
          ticker.volume = BigDecimal.new(market['volume24h'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
