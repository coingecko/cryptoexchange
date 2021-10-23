module Cryptoexchange::Exchanges
  module Bybit
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
          "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["result"].map do |pair|
            separator = /(BTC|ETH|EOS|XRP|USD|USDT)\z/ =~ pair['symbol']
            next if separator.nil?

            base   = pair['symbol'][0..separator - 1]
            target = pair['symbol'][separator..-1]
            inst_id = pair['symbol']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              contract_interval: 'perpetual',
              inst_id: inst_id,
              market: Bybit::Market::NAME
            )

            adapt(market_pair, pair)
          end.compact
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bybit::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.bid = NumericHelper.to_d(output['bid_price'])
          ticker.ask = NumericHelper.to_d(output['ask_price'])
          ticker.high = NumericHelper.to_d(output['high_price_24h'])
          ticker.low = NumericHelper.to_d(output['low_price_24h'])
          if market_pair.target == "USDT"
            ticker.volume = NumericHelper.to_d(output['volume_24h'])
          else
            ticker.volume = NumericHelper.to_d(output['turnover_24h'])
          end
          ticker.change = NumericHelper.to_d(output['price_24h_pcnt'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
