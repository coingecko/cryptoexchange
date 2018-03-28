  module Cryptoexchange::Exchanges
  module Crxzone
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
      
        def fetch(market_pair)
          pair_id = get_id(market_pair)
          output = super(ticker_url(pair_id))
          adapt(output["Result"], market_pair)
        end

        def ticker_url(pair_id)
          "#{Cryptoexchange::Exchanges::Crxzone::Market::API_URL}/Ticker?currencyPairID=#{pair_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Crxzone::Market::NAME
          ticker.ask = NumericHelper.to_d(output['Ask'])
          ticker.bid = NumericHelper.to_d(output['Bid'])
          ticker.last = NumericHelper.to_d(output['Last'])
          ticker.high = NumericHelper.to_d(output['High'])
          ticker.low = NumericHelper.to_d(output['Low'])
          ticker.volume = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = output['TimeStamp']
          ticker.payload = output
          ticker
        end

        def get_id(market_pair)
          currency_pairs = Cryptoexchange::Exchanges::Crxzone::Services::Pairs::CURRENCY_IDS
          pair_id = currency_pairs.select{ |object|
            object[:base] == market_pair.base.upcase &&
            object[:target] == market_pair.target.upcase }
          pair_id[0][:id]
        end
      end
    end
  end
end
