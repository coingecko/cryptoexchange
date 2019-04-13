module Cryptoexchange::Exchanges
  module Fubt
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
          "#{Cryptoexchange::Exchanges::Fubt::Market::API_URL}/market/tickers?accessKey=#{Cryptoexchange::Exchanges::Fubt::Market::ACCESS_KEY}"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            pair_name = ticker['tradeName']
            next if pair_name.nil?

            separator = Cryptoexchange::Exchanges::Coinex::Market::SEPARATOR_REGEX =~ pair_name.upcase
            next unless separator

            base = pair_name[0..separator - 1]
            target = pair_name[separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Fubt::Market::NAME
            })
            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Fubt::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.volume    = NumericHelper.to_d(output['vol24hour']   )

          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
