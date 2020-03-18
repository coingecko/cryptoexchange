module Cryptoexchange::Exchanges
  module Phemex
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
          "#{Cryptoexchange::Exchanges::Phemex::Market::API_URL}/ticker/24hr/all"
        end

        def adapt_all(output)
          output["result"].map do |output|
            base, target = Phemex::Market.separate_symbol(output["symbol"])

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: output["symbol"],
                            contract_interval: "perpetual",
                            market: Phemex::Market::NAME
                          )

            adapt(output, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base = market_pair.base
          contract_stat.target = market_pair.target
          contract_stat.market = Phemex::Market::NAME
          contract_stat.contract_type = "perpetual"

          contract_stat.open_interest = output['openInterest']
          contract_stat.index = output['indexEp'].to_f / 10000
          contract_stat.funding_rate_percentage = output["fundingRateEr"].to_f / 1000000
          contract_stat.payload = output
          contract_stat
        end
      end
    end
  end
end
