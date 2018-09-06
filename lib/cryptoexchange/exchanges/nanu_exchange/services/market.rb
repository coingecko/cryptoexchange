module Cryptoexchange::Exchanges
  module NanuExchange
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
          "#{Cryptoexchange::Exchanges::NanuExchange::Market::API_URL}=returnTicker"
        end

        def adapt_all(output)
          output.map do |pair|
            target, base = pair[1]['currencyPair'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: NanuExchange::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = NanuExchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low       = NumericHelper.to_d(output['min24hr'].to_f)
          ticker.bid       = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'].to_f)
          ticker.change    = NumericHelper.to_d(output['percentChange'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
