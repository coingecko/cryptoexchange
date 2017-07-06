module Cryptoexchange::Exchanges
  module Bitflyer
    module Services
      class Market < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(market_url(market_pair))
          adapt(output)
        end

        def market_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/ticker?product_code=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output)
          ticker = Bitflyer::Models::Ticker.new
          base, target = output['product_code'].split('_')
          ticker.base = base
          ticker.target = target
          ticker.market = Bitflyer::Market::NAME
          ticker.ask = output['best_ask']
          ticker.bid = output['best_bid']
          ticker.last = output['ltp']
          ticker.volume = output['volume_by_product']
          ticker.timestamp = Time.parse(output['timestamp']).to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
