module Cryptoexchange::Exchanges
  module Btcmex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          contract_stat_data = super(ticker_url)
          adapt_all(contract_stat_data)
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Btcmex::Market::API_URL}/ticker"
        end


        def adapt(pair, ticker)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = pair.split("USD")[0]
          contract_stat.target    = "USD"
          contract_stat.market    = Btcmex::Market::NAME
          contract_stat.index     = ticker["indexPrice"]
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil

          contract_stat.payload   = [pair, ticker]
          contract_stat.expire_timestamp = nil

          contract_stat.start_timestamp = nil
          contract_stat.contract_type = "perpetual"

          contract_stat.open_interest = ticker["openInterest"]
          contract_stat.funding_rate_percentage = ticker["fundingRate"] * 100
          contract_stat.next_funding_rate_timestamp = nil
          contract_stat.funding_rate_percentage_predicted = nil

          contract_stat
        end
      end
    end
  end
end
