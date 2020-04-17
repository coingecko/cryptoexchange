module Cryptoexchange::Exchanges
  module BitmartFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitmartFutures::Market::API_URL}/ifcontract/tickers"
        end

        def adapt(output, market_pair)
          output = output['data']['tickers'].find { |ticker| ticker['contract_id'] == market_pair.inst_id }
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitmartFutures::Market::NAME
          contract_stat.open_interest = output['position_size'].to_f
          contract_stat.index     = output['index_price'].to_f
          contract_stat.contract_type = "perpetual"
          contract_stat.index_identifier     = nil
          contract_stat.index_name           = nil
          contract_stat.payload   = output

          contract_stat.funding_rate_percentage     = output['funding_rate'].to_f * 100
          contract_stat.next_funding_rate_timestamp     = DateTime.parse(output['next_funding_at']).to_time.to_i
          contract_stat.funding_rate_percentage_predicted = nil

          contract_stat
        end
      end
    end
  end
end
