module Cryptoexchange::Exchanges
  module Coinflex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url(market_pair))
          adapt(open_interest, market_pair)
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinflex::Market::API_URL}/depth/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Coinflex::Market::NAME
          contract_stat.open_interest = adapt_orders(output['asks'], output['bids'])
          contract_stat.payload   = { "open_interest" => output }
          contract_stat
        end

        def adapt_orders(asks, bids)
          arr = []
          asks.map { |ask| arr << ask[1] }
          bids.map { |bid| arr << bid[1] }
          arr.inject(0, &:+)
        end
      end
    end
  end
end
