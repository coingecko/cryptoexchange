require 'pry'
module Cryptoexchange::Exchanges
  module Nusax
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
          "#{Cryptoexchange::Exchanges::Nusax::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          keys =  output.each_with_object([]) do |(k,v),keys|
                    keys << k
                  end
          tickers = keys.each.with_index do |key, index|
            output[keys[index]]["ticker"]
          end
          tickers.each do |ticker|
            market_pairs = []
            binding.pry
            pairs = output.map{|pair| pair["name"]}
              pairs.each do |pair|
                market_pairs << Cryptoexchange::Models::MarketPair.new(
                                  base: pair.split("/")[0],
                                  target: pair.split("/")[1],
                                  market: Nusax::Market::NAME
                                )
              adapt(market_pairs, nil)
            end
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Nusax::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.bid       = NumericHelper.to_d(market['buy'][0])
          ticker.ask       = NumericHelper.to_d(market['sell'][0])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
