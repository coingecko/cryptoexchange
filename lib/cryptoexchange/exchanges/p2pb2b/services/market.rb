require 'yaml'

module Cryptoexchange::Exchanges
  module P2pb2b
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          response = super(ticker_url)
          adapt_all(response)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::P2pb2b::Market::API_URL}/tickers"
        end

        def adapt_all(response)
          regular_expression = get_regular_expression
          response.map do |record|
            matches =  record[0].upcase.match(regular_expression)
            base, target = matches[1], matches[2]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: P2pb2b::Market::NAME
            )
            adapt(record, market_pair)   
          end
        end

        def adapt(record, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = P2pb2b::Market::NAME
          ticker.low       = NumericHelper.to_d(record[1]['ticker']['low'])
          ticker.high      = NumericHelper.to_d(record[1]['ticker']['high'])
          ticker.last      = NumericHelper.to_d(record[1]['ticker']['last'])
          ticker.bid       = NumericHelper.to_d(record[1]['ticker']['buy'])
          ticker.ask       = NumericHelper.to_d(record[1]['ticker']['sell'])         
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(record[1]['ticker']['vol']), ticker.last)
          ticker.timestamp = record[1]['at']
          ticker.payload   = record
          ticker
        end

        def get_regular_expression
          pairs = YAML.load_file(File.dirname(__FILE__)+'/../p2pb2b.yml')
          symbols = []
          pairs[:pairs].each do |pair|
            symbols << pair[:base]
            symbols << pair[:target]
          end
          /^(#{symbols.uniq.join('|')})(.+)$/i
        end
      end
    end
  end
end
