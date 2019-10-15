module Cryptoexchange::Exchanges
  module GmoJapanFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url) # do nothing with output, because assume type
          adapt(market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::GmoJapanFutures::Market::API_URL}/ticker"
        end

        def adapt(market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = GmoJapanFutures::Market::NAME
          contract_stat.contract_type = "perpetual" # Assume its all perpetual
          contract_stat
        end
      end
    end
  end
end
