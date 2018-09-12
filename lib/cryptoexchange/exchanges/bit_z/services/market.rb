module Cryptoexchange::Exchanges
  module BitZ
    module Services
      class Market < Cryptoexchange::Services::Market
        RESOLUTION = '1day'
        SIZE       = '1'
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output       = super(ticker_url(market_pair))
          kline_output = super(kline_url(market_pair))
          adapt(output, kline_output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BitZ::Market::API_URL}/Market/ticker?symbol=#{base}_#{target}"
        end

        def kline_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BitZ::Market::API_URL}/Market/kline?symbol=#{base}_#{target}&resolution=#{RESOLUTION}&size=#{SIZE}"
        end

        def adapt(output, kline_output, market_pair)
          market = HashHelper.dig(output, 'data')
          bar = HashHelper.dig(kline_output, 'data', 'bars').first
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitZ::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['askPrice'])
          ticker.bid       = NumericHelper.to_d(market['bidPrice'])
          ticker.last      = NumericHelper.to_d(bar['close'])
          ticker.high      = NumericHelper.to_d(bar['high'])
          ticker.low       = NumericHelper.to_d(bar['low'])
          ticker.volume    = NumericHelper.to_d(market['volume'])
          ticker.timestamp = Time.parse(bar['datetime']).to_i
          ticker.payload   = [output, kline_output]
          ticker
        end
      end
    end
  end
end
