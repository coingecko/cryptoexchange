module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        SWAP_URL = "#{Cryptoexchange::Exchanges::OkexSwap::Market::API_URL}/instruments"
        FUTURES_URL = "https://www.okex.com/api/futures/v3/instruments"

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
          contract_info = get_contract_info(market_pair)
          adapt(open_interest, index, contract_info, market_pair)
        end

        def get_contract_info(market_pair)
          contract_info = \
            if market_pair.contract_interval == "perpetual"
              HTTP.get("#{SWAP_URL}/#{market_pair.inst_id}/funding_time").parse(:json)
            else
              HTTP.get(FUTURES_URL).parse(:json)
            end
          process_contract_info(contract_info, market_pair)
        end

        def process_contract_info(contract_info, market_pair)
          arr = {}
          if market_pair.contract_interval == "perpetual"
            arr["funding_rate_percentage"] = contract_info["funding_rate"].to_f * 100
            arr["funding_rate_percentage_predicted"] = contract_info["estimated_rate"].to_f * 100
            arr["next_funding_timestamp"] = DateTime.parse(contract_info["settlement_time"]).to_time.to_i
          else
            contract = contract_info.find { |i| i["instrument_id"] == market_pair.inst_id }
            arr["expire_timestamp"] = DateTime.parse(contract["delivery"]).to_time.to_i
            arr["start_timestamp"] = DateTime.parse(contract["listing"]).to_time.to_i
          end
          arr
        end

        def open_interest_url(api_prefix, inst_id)
          "#{api_prefix}#{inst_id}/open_interest"
        end

        def index_url(api_prefix, inst_id)
          "#{api_prefix}#{inst_id}/index"
        end

        def adapt(open_interest, index, contract_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = OkexSwap::Market::NAME
          contract_stat.open_interest = open_interest['amount'].to_f
          contract_stat.index     = index['index'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }

          contract_stat.expire_timestamp = contract_info['expire_timestamp']
          contract_stat.start_timestamp = contract_info['start_timestamp']
          contract_stat.contract_type = contract_type(contract_stat.expire_timestamp)

          contract_stat.funding_rate_percentage = contract_info['funding_rate_percentage']
          contract_stat.next_funding_rate_timestamp = contract_info['next_funding_timestamp']
          contract_stat.funding_rate_percentage_predicted = contract_info['funding_rate_percentage_predicted']

          contract_stat
        end

        def contract_type(expire)
          if expire.nil?
            "perpetual"
          else
            "futures"
          end
        end
      end
    end
  end
end
