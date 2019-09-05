module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          unless market_pair.contract_interval == "perpetual"
            open_interest = super(open_interest_url(market_pair))
            index = super(index_url(market_pair))
            adapt(open_interest, index, market_pair)
          end
        end

        def open_interest_url(market_pair)
          "https://www.okex.com/api/futures/v3/instruments/#{market_pair.inst_id}/open_interest"
        end

        def index_url(market_pair)
          "https://www.okex.com/api/futures/v3/instruments/#{market_pair.inst_id}/index"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = OkexSwap::Market::NAME
          contract_stat.open_interest = open_interest['amount'].to_f
          contract_stat.index     = index['index'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
