module Cryptoexchange::Exchanges
  module BikiFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["data"]["tickers"][0], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BikiFutures::Market::API_URL}/tickers?instrumentID=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.contract_type = "perpetual"
          contract_stat.market    = BikiFutures::Market::NAME

          contract_stat.index     = output["index_px"].to_f
          contract_stat.funding_rate_percentage = output["funding_rate"].to_f * 100
          contract_stat.next_funding_rate_timestamp = Time.parse(output["next_funding_at"]).to_i
          contract_stat.payload   = output

          contract_stat
        end
      end
    end
  end
end
