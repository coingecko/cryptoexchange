module Cryptoexchange::Exchanges
  module Therocktrading
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Therocktrading::Market::API_URL}/funds/tickers"
        end

        def adapt_all(output)
          pairs = output['tickers'].map do |pair|
            separator = /(BTC|LTC|EUR|PPC|ETH|ZEC|BCH|NOKU|FDZ|GUSD|XRP|EURN)\z/ =~ pair['fund_id']

            next if separator.nil?

            base   = pair['fund_id'][0..separator - 1]
            target = pair['fund_id'][separator..-1]

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Therocktrading::Market::NAME
                          )
            adapt(pair, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          market = output
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Therocktrading::Market::NAME
          ticker.ask = NumericHelper.to_d(market['ask'])
          ticker.bid = NumericHelper.to_d(market['bid'])
          ticker.last = NumericHelper.to_d(market['last'])
          ticker.high = NumericHelper.to_d(market['high'])
          ticker.low = NumericHelper.to_d(market['low'])
          ticker.volume = NumericHelper.to_d(market['volume'])
          ticker.timestamp = nil
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
