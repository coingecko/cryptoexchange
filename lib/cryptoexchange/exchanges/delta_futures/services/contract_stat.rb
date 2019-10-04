module Cryptoexchange::Exchanges
  module DeltaFutures
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
          product_id = get_product_id(market_pair)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/orderbook/#{product_id}/l2"
        end

        def get_product_id(market_pair)
          url = "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/products"
          output = HTTP.get(url).parse(:json)
          pair = output.find { |i| i['symbol'] == market_pair.inst_id }
          pair['id']
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = DeltaFutures::Market::NAME
          contract_stat.funding_rate_percentage = output['funding_rate'].to_f
          contract_stat.index     = output['mark_price'].to_f
          contract_stat.payload   = output
          contract_stat
        end
      end
    end
  end
end
