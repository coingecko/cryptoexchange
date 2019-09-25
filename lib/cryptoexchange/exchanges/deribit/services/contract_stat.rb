module Cryptoexchange::Exchanges
  module Deribit
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

          adapt(open_interest, index, market_pair)
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_book_summary_by_instrument?instrument_name=#{market_pair.inst_id}&kind=future"
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_index?currency=#{market_pair.base}"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Deribit::Market::NAME
          contract_stat.open_interest = open_interest['result'][0]['open_interest'].to_f
          contract_stat.index     = index['result'][market_pair.base].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
