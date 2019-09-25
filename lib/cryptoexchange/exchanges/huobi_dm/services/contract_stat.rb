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

          adapt(open_interest, index)
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

        def adapt(open_interest, index)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = open_interest['data'][0]['symbol']
          contract_stat.target    = "USD"
          contract_stat.market    = HuobiDm::Market::NAME
          contract_stat.open_interest = open_interest['data'][0]['volume'].to_f
          contract_stat.index     = index['data'][0]['index_price'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
