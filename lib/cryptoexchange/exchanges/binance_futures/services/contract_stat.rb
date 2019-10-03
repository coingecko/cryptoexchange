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
          contract_info = super(contract_info_url(market_pair))

          adapt(nil, contract_info, market_pair)
        end

        # def open_interest_url(market_pair)
        #   TODO: pending
        # end

        def contract_info_url(market_pair)
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/premiumIndex?symbol=#{market_pair.inst_id}"
        end

        def adapt(open_interest, contract_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BinanceFutures::Market::NAME
          contract_stat.index     = contract_info['markPrice'].to_f
          contract_stat.funding_rate_percentage     = contract_info['lastFundingRate'].to_f * 100
          contract_stat.next_funding_rate_timestamp     = contract_info['nextFundingTime']/1000
          contract_stat.funding_rate_percentage_predicted = nil
          contract_stat.contract_type = "perpetual"
          contract_stat.payload   = { "contract_info" => contract_info }
          contract_stat
        end
      end
    end
  end
end
