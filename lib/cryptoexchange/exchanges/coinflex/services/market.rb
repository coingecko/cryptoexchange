module Cryptoexchange::Exchanges
  module Coinflex
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
          "#{Cryptoexchange::Exchanges::Coinflex::Market::API_URL}/tickers/"
        end

        def adapt_all(output)
          coins_list = JSON.parse(HTTP.get("#{Cryptoexchange::Exchanges::Coinflex::Market::API_URL}/assets/"))
          output.map do |pair|
            base = coins_list.select {|s| s["id"].to_s.casecmp(pair["base"].to_s) == 0 }.first
            target = coins_list.select {|s| s["id"].to_s.casecmp(pair["counter"].to_s) == 0 }.first

            unless base.key?("spot") && target.key?("spot")
              base = base["name"]
              target = target["name"]

              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              contract_interval: 'perpetual',
                              inst_id: "#{pair["base"]}:#{pair["counter"]}",
                              market: Coinflex::Market::NAME
                            )
              adapt(pair, market_pair)
            end
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval    = market_pair.contract_interval
          ticker.market    = Coinflex::Market::NAME
          ticker.bid       = output['bid'].to_f / 10000.0
          ticker.ask       = output['ask'].to_f / 10000.0
          ticker.last      = output['last'].to_f / 10000.0
          ticker.high      = output['high'].to_f / 10000.0
          ticker.low       = output['low'].to_f / 10000.0
          ticker.volume    = output['volume'].to_f / 10000.0
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
