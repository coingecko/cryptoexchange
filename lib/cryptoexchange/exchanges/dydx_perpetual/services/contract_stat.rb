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
          "#{Cryptoexchange::Exchanges::DydxPerpetual::Market::API_URL}/perpetual-markets/#{market_pair.inst_id}"
        end

        def get_index(index_price, market_pair)
          # dydx include base amount in their index price calculation.
          if market_pair.base == "BTC" && market_pair.target == "USDC"
            # The index price for BTC-USDC market pair.
            # 1 USDC has 6 decimal places, it display as 1e6 value.
            # Similarly, 1 BTC has 8 decimal places, so it returns 1e8 value.
            # If, USDC is now 9000 dollar to 1 BTC,
            # then will be: 9000e6 USDC/1e8 BTC = 90.0 (index price).
            return (index_price * 100).round(2) # to return the original value
          end

          nil
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
          contract_stat.index     =  get_index(contract_info['oraclePrice'].to_f, market_pair)
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
