module Cryptoexchange::Exchanges
  module JexFutures
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
          "#{Cryptoexchange::Exchanges::JexFutures::Market::API_URL}/contract/ticker/24hr"
        end

        def adapt_all(output)
          client = Cryptoexchange::Client.new
          pairs = client.pairs('jex')

          output.map do |ticker|
            # we don't want pair i.e., BINANACEETH, HUOBIETH etc
            next if ticker["symbol"].include? "ETF"
            pair = pairs.find { |i| "#{i.base}#{i.target}" == ticker["symbol"] }
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   pair.base,
              target: pair.target,
              market: JexFutures::Market::NAME
            )
            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker            = Cryptoexchange::Models::Ticker.new
          ticker.base       = market_pair.base
          ticker.target     = market_pair.target
          ticker.market     = JexFutures::Market::NAME
          ticker.last       = NumericHelper.to_d(output['lastPrice'])
          ticker.bid        = NumericHelper.to_d(output['bidPrice'])
          ticker.ask        = NumericHelper.to_d(output['askPrice'])
          ticker.change     = NumericHelper.to_d(output['priceChangePercent'])
          ticker.high       = NumericHelper.to_d(output['highPrice'])
          ticker.low        = NumericHelper.to_d(output['lowPrice'])
          ticker.volume     = NumericHelper.to_d(output['volume'])
          ticker.timestamp  = nil
          ticker.payload    = output
          ticker
        end

      end
    end
  end
end
