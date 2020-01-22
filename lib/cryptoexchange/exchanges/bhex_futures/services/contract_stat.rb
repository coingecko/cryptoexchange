module Cryptoexchange::Exchanges
  module BhexFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        FUNDING_RATE_URL = "https://api.bhex.com/openapi/contract/v1/fundingRate"
        INDEX_URL = "https://api.bhex.com/openapi/quote/v1/contract/index"

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          index = get_index(market_pair)
          funding_rate_percentage = get_funding_rate_percentage(market_pair)
          adapt(index, funding_rate_percentage, market_pair)
        end

        def adapt(index, funding_rate_percentage, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.contract_type = market_pair.contract_interval
          contract_stat.market    = BhexFutures::Market::NAME
          contract_stat.index     = index
          contract_stat.payload   = { "funding_rate_percentage" => funding_rate_percentage, "index" => index }
          contract_stat.funding_rate_percentage = funding_rate_percentage
          contract_stat
        end

        def get_index(market_pair)
          output = JSON.parse(HTTP.get("#{INDEX_URL}?symbol=#{market_pair.base.upcase}#{market_pair.target.upcase}"))
          output["index"]["#{market_pair.base.upcase}#{market_pair.target.upcase}"].to_f
        end

        def get_funding_rate_percentage(market_pair)
          output = JSON.parse(HTTP.get(FUNDING_RATE_URL))
          (output.find {|o| o['symbol'] == market_pair.inst_id}['rate'].to_f) * 100
        end
      end
    end
  end
end
