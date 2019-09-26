module Cryptoexchange::Exchanges
  module BitforexFutures
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
          adapt(open_interest["data"], index["data"], market_pair)
        end

        def open_interest_url(market_pair)
          "https://www.bitforex.com/contract/swap/contract/contractDetail/#{market_pair.inst_id}"
        end

        def index_url(market_pair)
          "https://www.bitforex.com/contract/swap/contract/commonInfo/#{market_pair.inst_id}"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitforexFutures::Market::NAME
          contract_stat.open_interest = open_interest['notBalanceNum'].to_f
          contract_stat.index     = index['indexPrice'].to_f
          contract_stat.payload   = { open_interest: open_interest, index: index }
          contract_stat
        end
      end
    end
  end
end
