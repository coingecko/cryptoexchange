module Cryptoexchange::Exchanges
  module Dragonex
    module Services
      class Market < Cryptoexchange::Services::Market
        # meaning of params please see: https://github.com/Dragonexio/OpenApi/blob/master/docs/English/1.interface_document_v1.md

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def inject_inst_id(market_pair)
          # todo: refactor to global
          if !(market_pair.respond_to? :inst_id) || (market_pair.send(:inst_id).nil?)
            market_pairs = Cryptoexchange::Client.new.pairs(Dragonex::Market::NAME)
            market_pair = market_pairs.detect { |mp| mp.base == market_pair.base && mp.target == market_pair.target }
          end

          market_pair
        end

        def fetch(market_pair)
          market_pair = inject_inst_id(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dragonex::Market::API_URL}/api/v1/market/real?symbol_id=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          market           = HashHelper.dig(output, 'data').first
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Dragonex::Market::NAME
          ticker.high      = NumericHelper.to_d(market['max_price'])
          ticker.low       = NumericHelper.to_d(market['min_price'])
          ticker.last      = NumericHelper.to_d(market['close_price'])
          ticker.volume    = NumericHelper.to_d(market['total_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
