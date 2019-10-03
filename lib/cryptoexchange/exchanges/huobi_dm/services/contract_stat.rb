module Cryptoexchange::Exchanges
  module HuobiDm
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
          contract_info = super(contract_info_url(market_pair))
          adapt(open_interest, index, contract_info)
        end

        def open_interest_url(market_pair)
          interval_list = { "CW"=> "this_week", "NW"=> "next_week", "CQ"=> "quarter" }
          interval_key = market_pair.inst_id.split("_")[1]
          interval_value = interval_list[interval_key]
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/api/v1/contract_open_interest?symbol=#{market_pair.base}&contract_type=#{interval_value}"
        end

        def index_url(market_pair)
          symbol = market_pair.inst_id.split("_")[0]
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/api/v1/contract_index?symbol=#{symbol}"
        end

        def contract_info_url(market_pair)
          interval_list = { "CW"=> "this_week", "NW"=> "next_week", "CQ"=> "quarter" }
          interval_key = market_pair.inst_id.split("_")[1]
          interval_value = interval_list[interval_key]
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/api/v1/contract_contract_info?symbol=#{market_pair.base}&contract_type=#{interval_value}"
        end

        def adapt(open_interest, index, contract_info)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = open_interest['data'][0]['symbol']
          contract_stat.target    = "USD"
          contract_stat.market    = HuobiDm::Market::NAME
          contract_stat.open_interest = open_interest['data'][0]['volume'].to_f
          contract_stat.index     = index['data'][0]['index_price'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat.expire_timestamp = unix_timestamp(contract_info['data'][0]['delivery_date'])
          contract_stat.start_timestamp = unix_timestamp(contract_info['data'][0]['create_date'])
          contract_stat.contract_type = contract_type(contract_stat.expire_timestamp)
          contract_stat
        end

        def unix_timestamp(date)
          year, month, day = date[0..3], date[4..5], date[6..7]
          new_date = "#{year}-#{month}-#{day}"
          DateTime.parse(new_date).to_time.to_i
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
