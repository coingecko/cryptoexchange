module Cryptoexchange::Exchanges
  module CoinMetro
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
          "#{Cryptoexchange::Exchanges::CoinMetro::Market::API_URL}/prices"
        end

        def adapt_all(output)          
        
          latest_prices = output['latestPrices']
          info = output['24hInfo']
          latest_prices.each_with_index.map do |data, idx|
            pair = data['pair']
            base = pair[0, 3]
            target = pair[3, 3]            
            
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: CoinMetro::Market::NAME
                          )            
            
            adapt(data, info[idx], market_pair)
          end
        end

        def adapt(output, info, market_pair)
          if output.empty?
            nil
          else
            ticker = Cryptoexchange::Models::Ticker.new            
            ticker.base = market_pair.base            
            ticker.target = market_pair.target
            ticker.market = CoinMetro::Market::NAME
            ticker.ask = NumericHelper.to_d(output['ask'])
            ticker.bid = NumericHelper.to_d(output['bid'])
            ticker.last = NumericHelper.to_d(output['price'])
            ticker.high = NumericHelper.to_d(info['h'])
            ticker.low = NumericHelper.to_d(info['l'])
            ticker.volume = NumericHelper.to_d(info['v'])
            ticker.timestamp = output['timestamp'].to_i / 1000
            ticker.payload = output.merge(info)
            ticker
          end
        end
      end
    end
  end
end
