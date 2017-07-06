module Cryptoexchange::Exchanges
  module Gatecoin
    module Services
      class Market < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(market_url)
          adapt(output, market_pair)
        end

        def market_url
          "#{Cryptoexchange::Exchanges::Gatecoin::Market::API_URL}/Public/LiveTickers"
        end

        def adapt(output, market_pair)
          # base
          # target
          # market (exchange_str)
          # last
          # bid
          # ask
          # high
          # low
          # volume
          # timestamp

          data = output['tickers']
          ticker_match = data.find do |datum|
            datum['currencyPair'] == market_pair.base + market_pair.target
          end

          ticker = Gatecoin::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = 'gatecoin'
          ticker.last = ticker_match['last']
          ticker.bid = ticker_match['bid']
          ticker.ask = ticker_match['ask']
          ticker.high = ticker_match['high']
          ticker.low = ticker_match['low']
          ticker.volume = ticker_match['volume'] # TODO: Check if it is base denominated?
          ticker.timestamp = ticker_match['createDateTime'].to_i
          ticker
        end
      end
    end
  end
end
