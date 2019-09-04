module Cryptoexchange::Exchanges
  module Bybit
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          puts output
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/tickers"
        end
      end
    end
  end
end
