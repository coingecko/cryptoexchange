module Cryptoexchange::Exchanges
  module Btc24
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output,market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btc24::Market::API_URL}/quotehistory/#{market_pair.base.downcase}#{market_pair.target.downcase}/1440/bars/bid?timestamp=#{Time.now.to_i - 86400 * 7}&count=1"
        end

        def adapt(output,market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new

          bid              = output['Bars'].first
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitbank::Market::NAME
          ticker.last      = NumericHelper.to_d(bid['Close'])
          ticker.high      = NumericHelper.to_d(bid['High'])
          ticker.low       = NumericHelper.to_d(bid['Low'])
          ticker.volume    = NumericHelper.to_d(bid['Volume'])
          ticker.timestamp = bid['Timestamp'] / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
