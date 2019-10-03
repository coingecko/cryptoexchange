module Cryptoexchange::Exchanges
  module CmeFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url)
          adapt_all(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::CmeFutures::Market::API_URL}/CmeWS/mvc/Quotes/Future/8478/G?pageSize=500&_=1564549645686"
        end

        def adapt_all(output, market_pair)
          contract = output["quotes"].find { |i| i["quoteCode"] == market_pair.inst_id }
          adapt(contract, market_pair)
        end

        def adapt(contract, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = CmeFutures::Market::NAME
          contract_stat.open_interest = nil
          contract_stat.index     = nil

          contract_stat.expire_timestamp = contract['lastTradeDate']['timestamp']/1000
          contract_stat.start_timestamp = nil
          contract_stat.contract_type = "futures"

          contract_stat.payload   = contract
          contract_stat
        end
      end
    end
  end
end
