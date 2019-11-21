module Cryptoexchange::Exchanges
  module GateFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest_data = super(open_interest_url)
          open_interest = open_interest_data.select { |s| s['contract'] == market_pair.inst_id }.first
          contract_info = super(contract_info_url(market_pair))

          adapt(open_interest, contract_info, market_pair)
        end

        def open_interest_url
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/tickers"
        end

        def contract_info_url(market_pair)
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/contracts/#{market_pair.inst_id}"
        end


        def adapt(open_interest, contract_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = GateFutures::Market::NAME
          contract_stat.open_interest = open_interest['total_size'].to_f
          contract_stat.index     = contract_info['index_price'].to_f
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          contract_stat.funding_rate_percentage     = contract_info['funding_rate'].to_f * 100
          contract_stat.next_funding_rate_timestamp     = contract_info['funding_next_apply']
          contract_stat.funding_rate_percentage_predicted     = contract_info['funding_rate_indicative'].to_f * 100
          contract_stat.contract_type = "perpetual"

          contract_stat.payload   = { "open_interest" => open_interest, "contract_info" => contract_info }
          contract_stat
        end
      end
    end
  end
end
