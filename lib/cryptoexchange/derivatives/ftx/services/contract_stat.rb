module Cryptoexchange::Exchanges
  module Ftx
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url(market_pair))
          index = super(index_url(market_pair))

          adapt(open_interest, index, market_pair)
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}/stats"
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Ftx::Market::NAME
          contract_stat.open_interest = open_interest['result']['openInterest'].to_f
          contract_stat.index     = index['result']['index'].to_f
          contract_stat.funding_rate = open_interest['result']['nextFundingRate'].to_f if open_interest['result']['nextFundingRate']
          contract_stat.funding_rate_timestamp = DateTime.parse(open_interest['result']['nextFundingTime']).to_time.to_i if open_interest['result']['nextFundingTime']
          # contract_stat.next_funding_rate_predicted 
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
