module Cryptoexchange::Exchanges
  module Cryptopia
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Cryptopia::Market::API_URL}/GetMarket/#{base}_#{target}"
        end

        def adapt(output)
          data = output['Data']
          base, target = data['Label'].split('/')

          ticker           = Cryptopia::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Cryptopia::Market::NAME
          ticker.last      = data['LastPrice'] ? BigDecimal.new(data['LastPrice'].to_s) : nil
          ticker.bid       = data['BidPrice'] ? BigDecimal.new(data['BidPrice'].to_s) : nil
          ticker.ask       = data['AskPrice'] ? BigDecimal.new(data['AskPrice'].to_s) : nil
          ticker.high      = data['High'] ? BigDecimal.new(data['High'].to_s) : nil
          ticker.low       = data['Low'] ? BigDecimal.new(data['Low'].to_s) : nil
          ticker.volume    = data['Volume'] ? BigDecimal.new(data['Volume'].to_s) : nil
          ticker.change    = data['Change'] ? BigDecimal.new(data['Change'].to_s) : nil
          ticker.timestamp = Time.now.to_i
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
