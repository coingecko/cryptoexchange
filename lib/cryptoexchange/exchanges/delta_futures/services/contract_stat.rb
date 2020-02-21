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
          product = super(products_url).find { |i| i['symbol'] == market_pair.inst_id }
          output = super(ticker_url(product['id']))
          index_data = super(index_url(product['spot_index']['symbol']))
          adapt(output, product, index_data, market_pair)
        end

        def ticker_url(id)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/orderbook/#{id}/l2"
        end

        def products_url
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/products"
        end

        def index_url(product_id)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/chart/history?symbol=#{product_id}&from=#{Time.now.to_i - 500}&to=#{Time.now.to_i}&resolution=1"
        end

        def adapt(output, product, index_data, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = DeltaFutures::Market::NAME
          contract_stat.funding_rate_percentage = output['funding_rate'].to_f
          contract_stat.index     = index_data["c"][-1]
          contract_stat.index_identifier = product["spot_index"]["symbol"].gsub(".", "")
          contract_stat.index_name = product["spot_index"]["symbol"]
          contract_stat.contract_type = contract_type(product['contract_type'])
          contract_stat.payload   = output
          contract_stat
        end

        def contract_type(instrument_type)
          if instrument_type == "perpetual_futures"
            "perpetual"
          elsif instrument_type == "futures"
            "futures"
          end
        end
      end
    end
  end
end
