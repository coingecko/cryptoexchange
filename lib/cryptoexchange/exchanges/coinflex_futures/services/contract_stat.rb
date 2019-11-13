module Cryptoexchange::Exchanges
  module CoinflexFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url # do nothing with output, because assume type
          adapt(market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/tickers/"
        end

        def adapt(market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = CoinflexFutures::Market::NAME
          contract_stat.contract_type = "futures" # Assume all futures, handled by pairs list
          contract_stat.index_identifier = "CoinflexFutures-#{market_pair.base}/#{market_pair.target}"
          contract_stat.index_name = "Coinflex #{market_pair.base}/#{market_pair.target}"

          contract_stat
        end
      end
    end
  end
end
