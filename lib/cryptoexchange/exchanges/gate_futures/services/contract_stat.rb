module Cryptoexchange::Exchanges
  module GateFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest_data = super(open_interest_url)
          open_interest = open_interest_data.select { |s| s['contract'] == market_pair.inst_id }.first
          index = super(index_url(market_pair))

          adapt(open_interest, index, market_pair)
        end

        def open_interest_url
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/tickers"
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/contracts/#{market_pair.inst_id}"
        end


        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = GateFutures::Market::NAME
          contract_stat.open_interest = open_interest['total_size'].to_f
          contract_stat.index     = index['index_price'].to_f
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }
          contract_stat
        end
      end
    end
  end
end
