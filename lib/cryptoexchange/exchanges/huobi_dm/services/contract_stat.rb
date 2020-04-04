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
          contract_interval = market_pair.contract_interval
          if contract_interval == "perpetual"
            open_interest = super(swap_open_interest_url(market_pair))
            index = super(swap_index_url(market_pair))
            contract_info = super(swap_contract_info_url(market_pair))
            funding_rate = super(swap_funding_rate_url(market_pair))
          else
            open_interest = super(open_interest_url(market_pair))
            index = super(index_url(market_pair))
            contract_info = super(contract_info_url(market_pair))
            funding_rate = nil
          end
          puts "lets adapt"
          adapt(open_interest, index, contract_info, contract_interval, funding_rate)
        end

        def swap_open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-api/v1/swap_open_interest?contract_code=#{market_pair.inst_id}"
        end

        def swap_index_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-api/v1/swap_index?contract_code=#{market_pair.inst_id}"
        end

        def swap_contract_info_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-api/v1/swap_contract_info?contract_code=#{market_pair.inst_id}"
        end

        def swap_funding_rate_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-api/v1/swap_funding_rate?contract_code=#{market_pair.inst_id}"
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

        def adapt(open_interest, index, contract_info, contract_interval, funding_rate)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          if contract_interval == "perpetual"
            base, target = open_interest['data'][0]['contract_code'].split '-'
            contract_stat.base      = base
            contract_stat.target    = target
            contract_stat.index_identifier = "HuobiDm-#{index['data'][0]['contract_code']}"
            contract_stat.index_name = "Huobi DM #{index['data'][0]['contract_code']}"
            contract_stat.funding_rate_percentage = funding_rate['data']['funding_rate'].to_f
            contract_stat.next_funding_rate_timestamp = (funding_rate['data']['funding_time'].to_i / 1000)
            contract_stat.funding_rate_percentage_predicted = funding_rate['data']['estimated_rate'].to_f
          else
            contract_stat.base      = open_interest['data'][0]['symbol']
            contract_stat.target    = "USD"
            contract_stat.index_identifier = "HuobiDm-#{index['data'][0]['symbol']}"
            contract_stat.index_name = "Huobi DM #{index['data'][0]['symbol']}"
            contract_stat.expire_timestamp = unix_timestamp(contract_info['data'][0]['delivery_date'])
            contract_stat.start_timestamp = unix_timestamp(contract_info['data'][0]['create_date'])
          end
          contract_stat.market    = HuobiDm::Market::NAME
          contract_stat.open_interest = open_interest['data'][0]['volume'].to_f
          contract_stat.index     = index['data'][0]['index_price'].to_f
          
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          
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
