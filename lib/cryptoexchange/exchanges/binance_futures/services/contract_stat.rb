module Cryptoexchange::Exchanges
  module BinanceFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          if market_pair.contract_interval == "perpetual"
            root_api_url = Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL
            futures_expire_info = nil
          elsif market_pair.contract_interval == "futures"
            root_api_url = Cryptoexchange::Exchanges::BinanceFutures::Market::FUTURES_API_URL
            futures_expire_info = super(futures_expire_url(market_pair))
            futures_expire_info = futures_expire_info["symbols"].select { |exchange_info| exchange_info["symbol"] == market_pair.inst_id }.first
          end

          contract_info = super(contract_info_url(root_api_url, market_pair))
          open_interest_info = super(open_interest_url(root_api_url, market_pair))
          
          adapt(contract_info, open_interest_info, futures_expire_info, market_pair)
        end

        def open_interest_url(root_api_url, market_pair)
          "#{root_api_url}/openInterest?symbol=#{market_pair.inst_id}"
        end

        def contract_info_url(root_api_url, market_pair)
          "#{root_api_url}/premiumIndex?symbol=#{market_pair.inst_id}"
        end

        def futures_expire_url(market_pair)
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::FUTURES_API_URL}/exchangeInfo"
        end

        def adapt(contract_info, open_interest_info, futures_expire_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BinanceFutures::Market::NAME
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil

          contract_stat.open_interest = open_interest_info["openInterest"].to_f

          if market_pair.contract_interval == "perpetual"
            contract_stat.index     = contract_info['markPrice'].to_f
            contract_stat.funding_rate_percentage     = contract_info['lastFundingRate'].to_f * 100
            contract_stat.next_funding_rate_timestamp     = contract_info['nextFundingTime']/1000
            contract_stat.funding_rate_percentage_predicted = nil
            contract_stat.contract_type = "perpetual"
            contract_stat.payload   =  contract_info
          elsif market_pair.contract_interval == "futures"
            contract_stat.index     = contract_info[0]['markPrice'].to_f
            contract_stat.contract_type = "futures"
            contract_stat.payload   =  contract_info[0]
            
            expire_timestamp = futures_expire_info['deliveryDate'] / 1000
            start_timestamp = futures_expire_info['onboardDate'] / 1000
            contract_stat.expire_timestamp = expire_timestamp
            contract_stat.start_timestamp = start_timestamp
          end
          contract_stat
        end
      end
    end
  end
end
