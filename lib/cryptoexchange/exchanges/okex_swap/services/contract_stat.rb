module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        PAIRS_URL = "https://www.okex.com/api/futures/v3/instruments"
        CONTRACT_STAT_URL = "https://www.okex.com/api/futures/v3/instruments/"

        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = JSON.parse(HTTP.get(PAIRS_URL))
          output.map do |data|
            data_open_interest_url =  open_interest_url(data["instrument_id"])
            data_index_url = index_url(data["instrument_id"])
            open_interest = super(data_open_interest_url)
            index = super(data_index_url)
            market_pair = [data["underlying_index"], data["quote_currency"]]
            adapt(open_interest, index, market_pair)
          end
        end

        def open_interest_url(inst_id)
          "#{CONTRACT_STAT_URL}#{inst_id}/open_interest"
        end

        def index_url(inst_id)
          "#{CONTRACT_STAT_URL}#{inst_id}/index"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair[0]
          contract_stat.target    = market_pair[1]
          contract_stat.market    = OkexSwap::Market::NAME
          contract_stat.open_interest = open_interest['amount'].to_f
          contract_stat.index     = index['index'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
