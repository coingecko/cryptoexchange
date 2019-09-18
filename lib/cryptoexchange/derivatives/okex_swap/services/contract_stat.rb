require 'byebug'
module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        FUTURES_URL = "https://www.okex.com/api/futures/v3/instruments/"
        SWAP_URL = "https://www.okex.com/api/swap/v3/instruments/"

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          if market_pair.expire_date.nil?
            open_interest = super(open_interest_url(SWAP_URL, market_pair.inst_id))
            index = super(index_url(SWAP_URL, market_pair.inst_id))
            funding = super(funding_rate_url(SWAP_URL, market_pair.inst_id))
          else
            open_interest = super(open_interest_url(FUTURES_URL, market_pair.inst_id))
            index = super(index_url(FUTURES_URL, market_pair.inst_id))
            funding = nil
          end

          adapt(open_interest, index, funding, market_pair)
        end

        def open_interest_url(url_prefix, inst_id)
          "#{url_prefix}#{inst_id}/open_interest"
        end

        def index_url(url_prefix, inst_id)
          "#{url_prefix}#{inst_id}/index"
        end

        def funding_rate_url(url_prefix, inst_id)
          "#{url_prefix}#{inst_id}/funding_time"
        end

        def adapt(open_interest, index, funding, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = OkexSwap::Market::NAME
          contract_stat.open_interest = open_interest['amount'].to_f
          contract_stat.index     = index['index'].to_f
          if funding
            contract_stat.funding_rate = funding["funding_rate"].to_f
            contract_stat.funding_rate_timestamp = DateTime.parse(funding["funding_time"]).to_time.to_i
            contract_stat.next_funding_rate_predicted = funding["estimated_rate"].to_f
          end
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index, "funding" => funding }
          contract_stat
        end
      end
    end
  end
end
