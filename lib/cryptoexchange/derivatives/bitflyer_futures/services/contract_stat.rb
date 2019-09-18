module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          index = super(index_url(market_pair))

          adapt(nil, index, market_pair)
        end

        # def open_interest_url(market_pair)
        #   TODO: pending
        # end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/ticker?product_code=#{market_pair.inst_id}"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitflyerFutures::Market::NAME
          # contract_stat.open_interest (pending)
          contract_stat.index     = index['ltp'].to_f
          # contract_stat.funding_rate (pending)
          # contract_stat.funding_rate_timestamp (pending)
          contract_stat.payload   = { "index" => index }

          contract_stat
        end
      end
    end
  end
end
