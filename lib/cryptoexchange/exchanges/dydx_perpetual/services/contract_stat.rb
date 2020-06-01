module Cryptoexchange::Exchanges
  module DydxPerpetual
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          contract_info = super(contract_info_url(market_pair))
          adapt(market_pair, contract_info['market'])
        end

        def contract_info_url(market_pair)
          "#{Cryptoexchange::Exchanges::DydxPerpetual::Market::API_URL}/perpetual-markets/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(market_pair, contract_info)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = DydxPerpetual::Market::NAME
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          contract_stat.funding_rate_percentage = contract_info['fundingRate'] ? contract_info['fundingRate'] * 100 : nil
          contract_stat.open_interest = contract_info['openInterest'] ? contract_info['openInterest'].to_f : nil
          # contract_stat.index
          # contract_stat.payload
          # contract_stat.next_funding_rate_timestamp
          # contract_stat.funding_rate_percentage_predicted
          contract_stat.contract_type = "perpetual"

          contract_stat
        end
      end
    end
  end
end
