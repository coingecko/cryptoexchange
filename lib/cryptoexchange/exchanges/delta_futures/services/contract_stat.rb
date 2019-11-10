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
          adapt(output, product, market_pair)
        end

        def ticker_url(id)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/orderbook/#{id}/l2"
        end

        def products_url
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/products"
        end

        def adapt(output, product, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = DeltaFutures::Market::NAME
          contract_stat.funding_rate_percentage = output['funding_rate'].to_f
          contract_stat.index     = output['mark_price'].to_f
          contract_stat.index_identifier = "DeltaFutures~#{market_pair.base}"
          contract_stat.index_name = "Delta Exchange #{market_pair.base}"
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
