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

          ticker           = Novaexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Novaexchange::Market::NAME
          ticker.last      = market['last_price'] ? BigDecimal.new(market['last_price'].to_s) : nil
          ticker.bid       = market['bid'] ? BigDecimal.new(market['bid'].to_s) : nil
          ticker.ask       = market['ask'] ? BigDecimal.new(market['ask'].to_s) : nil
          ticker.high      = market['high24h'] ? BigDecimal.new(market['high24h'].to_s) : nil
          ticker.low       = market['low24h'] ? BigDecimal.new(market['low24h'].to_s) : nil
          ticker.volume    = market['volume24h'] ? BigDecimal.new(market['volume24h'].to_s) : nil
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
