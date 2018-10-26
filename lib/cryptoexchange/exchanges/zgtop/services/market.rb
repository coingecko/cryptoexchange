module Cryptoexchange::Exchanges
  module Zgtop
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          market_pair = inject_inst_id(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def inject_inst_id(market_pair)
          # todo: refactor to global
          if !(market_pair.respond_to? :inst_id) || (market_pair.send(:inst_id).nil?)
            market_pairs = Cryptoexchange::Client.new.pairs(Zgtop::Market::NAME)
            market_pair = market_pairs.detect { |mp| mp.base == market_pair.base && mp.target == market_pair.target }
          end

          market_pair
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Zgtop::Market::API_URL}/ticker?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Zgtop::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
