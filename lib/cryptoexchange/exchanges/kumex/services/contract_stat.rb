module Cryptoexchange::Exchanges
  module Kumex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(contracts_url)
          adapt(output['data'], market_pair)
        end

        def contracts_url
          "#{Cryptoexchange::Exchanges::Kumex::Market::API_URL}/contracts/active"
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Kumex::Market::NAME
          # contract_stat.open_interest
          # contract_stat.index    
          # contract_stat.payload  
          # contract_stat.expire_timestamp
          # contract_stat.start_timestamp
          contract_stat.contract_type = contract_type(output, market_pair.inst_id)
          # contract_stat.funding_rate_percentage
          # contract_stat.next_funding_rate_timestamp
          # contract_stat.funding_rate_percentage_predicted

          contract_stat
        end

        def contract_type(output, inst_id)
          contract = output.select { |o| o['symbol'] == inst_id }.first

          if contract['type'] == "FFWCSX"
            "perpetual"
          end
          # TODO: Futures not support yet by API or exchange, implement later
        end
      end
    end
  end
end
