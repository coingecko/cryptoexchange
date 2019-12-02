module Cryptoexchange::Exchanges
  module Fmex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url)
          ticker = super(ticker_url)
          index_and_funding_rate = super(index_and_funding_rate_url)
          adapt(open_interest['data'], ticker['data'], index_and_funding_rate['data'], market_pair)
        end

        def open_interest_url
          "https://fmex.com/api/contracts/web/v3/public/statistics"
        end

        def index_and_funding_rate_url
          "#{Cryptoexchange::Exchanges::Fmex::Market::API_URL}/market/indexes"
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Fmex::Market::API_URL}/public/contracts/symbols"
        end

        def adapt(open_interest, ticker, index_and_funding_rate, market_pair)
          ticker = ticker.select { |o| o["name"] == market_pair.inst_id }.first
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Fmex::Market::NAME
          contract_stat.open_interest = open_interest.dig(market_pair.inst_id.upcase).to_f

          if contract_stat.base == "BTC"
            contract_stat.index     = index_and_funding_rate['.btcusd_spot'][1]
            contract_stat.index_identifier     = nil
            contract_stat.index_name           = nil
          end

          contract_stat.contract_type = contract_type(ticker['type'])
          contract_stat.funding_rate_percentage = index_and_funding_rate['.btcusdfr8h'][1] ? index_and_funding_rate['.btcusdfr8h'][1] * 100 : nil
          contract_stat.next_funding_rate_timestamp = index_and_funding_rate['.btcusdfr8h'][0] ? (index_and_funding_rate['.btcusdfr8h'][0] / 1000) : nil
          contract_stat.funding_rate_percentage_predicted = index_and_funding_rate['.btcusdfr'][1] ? index_and_funding_rate['.btcusdfr'][1] * 100 : nil

          if contract_stat.contract_type == "perpetual"
            expire_timestamp = nil
            start_timestamp = nil
          end

          contract_stat.payload   = { open_interest: open_interest, ticker: ticker, index_and_funding_rate: index_and_funding_rate }

          contract_stat
        end

        def contract_type(instrument_type)
          if instrument_type == "perpetual"
            "perpetual"
          end
        end
      end
    end
  end
end
