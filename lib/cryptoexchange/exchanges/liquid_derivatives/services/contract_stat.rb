module Cryptoexchange::Exchanges
  module LiquidDerivatives
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::LiquidDerivatives::Market::API_URL}/products?perpetual=1"
        end

        def adapt_all(output)
          output.map do |output|
            base = output["base_currency"].split("-")[1]
            target = output["quoted_currency"]

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: output["currency_pair_code"],
                            contract_interval: output["product_type"].downcase,
                            market: LiquidDerivatives::Market::NAME
                          )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base = market_pair.base
          contract_stat.target = market_pair.target
          contract_stat.market = LiquidDerivatives::Market::NAME
          contract_stat.contract_type = market_pair.contract_interval

          contract_stat.index = output['index_price'].to_f
          contract_stat.funding_rate_percentage = output["funding_rate"].to_f * 100
          contract_stat.payload = output
          contract_stat
        end
      end
    end
  end
end
