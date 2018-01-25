module Cryptoexchange::Exchanges
  module Hksy
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Hksy::Market::MARKET_API_URL}/selectCoinMarketbyCoinName?coinName=#{base}&payCoinName=#{target}"
        end

        def adapt(output, market_pair)
          market = output["model"]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Hksy::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['sellprice'])
          ticker.bid       = NumericHelper.to_d(market['buyprice'])
          ticker.last      = NumericHelper.to_d(market['newclinchprice'])
          ticker.high      = NumericHelper.to_d(market['highprice'])
          ticker.low       = NumericHelper.to_d(market['lowprice'])
          ticker.volume    = NumericHelper.to_d(market['count24'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
