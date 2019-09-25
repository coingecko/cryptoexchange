module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        PAIRS_URL = "https://www.okex.com/api/futures/v3/instruments"
        CONTRACT_STAT_URL = "https://www.okex.com/api/futures/v3/instruments/"

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          api_prefix = if market_pair.contract_interval == "perpetual"
            "https://www.okex.com/api/swap/v3/instruments/"
          else
            "https://www.okex.com/api/futures/v3/instruments/"
          end

          open_interest = super(open_interest_url(api_prefix, market_pair.inst_id))
          index = super(index_url(api_prefix, market_pair.inst_id))
          adapt(open_interest, index, market_pair)
        end

        def open_interest_url(api_prefix, inst_id)
          "#{api_prefix}#{inst_id}/open_interest"
        end

        def index_url(api_prefix, inst_id)
          "#{api_prefix}#{inst_id}/index"
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
