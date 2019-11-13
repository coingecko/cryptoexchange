module Cryptoexchange::Exchanges
  module BiboxFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          adapt(market_pair)
        end

        def adapt(market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BiboxFutures::Market::NAME
          contract_stat.index_identifier = "Bibox~#{market_pair.base}/#{market_pair.target}"
          contract_stat.index_name = "Bibox #{market_pair.base}/#{market_pair.target}"

          contract_stat.contract_type = "perpetual"
          contract_stat
        end
      end
    end
  end
end
