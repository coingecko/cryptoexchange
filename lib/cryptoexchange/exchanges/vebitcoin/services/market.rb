module Cryptoexchange::Exchanges
  module Vebitcoin
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
          "#{Cryptoexchange::Exchanges::Vebitcoin::Market::API_URL}/Ticker/All"
        end

        def adapt_all(output)
          output.map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   ticker['Code'],
              target: Vebitcoin::Services::Pairs::TARGET,
              market: Vebitcoin::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Vebitcoin::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = Time.parse(output['Time']).to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
