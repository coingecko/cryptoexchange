module Cryptoexchange::Exchanges
  module Exchangeassets
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end
require 'byebug'
        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Exchangeassets::Market::API_URL}/ticker/"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair[0].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base.upcase,
              target: target.upcase,
              market: Exchangeassets::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Exchangeassets::Market::NAME
          ticker.high      = NumericHelper.to_d(output['bid_24h_max'])
          ticker.low       = NumericHelper.to_d(output['ask_24h_min'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['vol_24h'])
          ticker.timestamp = output['updated'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
