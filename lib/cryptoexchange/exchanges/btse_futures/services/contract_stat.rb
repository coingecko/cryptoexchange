module Cryptoexchange::Exchanges
  module BtseFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BtseFutures::Market::API_URL}/market_summary"
        end

        def adapt(output, market_pair)
          output = output.find { |i| i["symbol"] == market_pair.inst_id }
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BtseFutures::Market::NAME
          contract_stat.payload   = output

          expire_timestamp = output['contract_end']
          start_timestamp = output['contract_start']

          contract_stat.expire_timestamp = expire_timestamp
          contract_stat.start_timestamp = start_timestamp
          contract_stat.open_interest = output['openInterest']
          contract_stat.contract_type = contract_type(start_timestamp, expire_timestamp)
          contract_stat
        end

        def contract_type(start, expire)
          if expire == ""
            "perpetual"
          else
            "futures"
          end
        end
      end
    end
  end
end
