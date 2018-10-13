module Cryptoexchange::Exchanges
  module Coinpulse
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
          "#{Cryptoexchange::Exchanges::Coinpulse::Market::API_URL}/ticker/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Coinpulse::Market::NAME

          if output.key?('result') and !output['result'][0].nil?
            ticker.ask       = NumericHelper.to_d(output['result'][0]['Ask'])
            ticker.bid       = NumericHelper.to_d(output['result'][0]['Bid'])
            ticker.high      = NumericHelper.to_d(output['result'][0]['High'])
            ticker.last      = NumericHelper.to_d(output['result'][0]['Last'])
            ticker.volume    = NumericHelper.to_d(output['result'][0]['BaseVolume'])
          end

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
