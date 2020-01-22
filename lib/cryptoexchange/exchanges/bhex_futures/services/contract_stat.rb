module Cryptoexchange::Exchanges
  module BhexFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BhexFutures::Market::API_URL}/brokerInfo"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["symbol"].split("-SWAP-")
            next if base == nil || target == nil
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: ticker["symbol"],
                            contract_interval: "perpetual",
                            market: BhexFutures::Market::NAME
                          )

            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base = market_pair.base
          contract_stat.target = market_pair.target
          contract_stat.market = BhexFutures::Market::NAME
          contract_stat.contract_type = market_pair.contract_interval

          contract_stat.open_interest = output['openInterest']
          contract_stat.index = output['indexPrice']
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          contract_stat.funding_rate_percentage = output["fundingRate"] * 100
          contract_stat.next_funding_rate_timestamp = output["nextFundingTime"] / 1000
          contract_stat.funding_rate_percentage_predicted = output["nextFundingRate"] * 100
          contract_stat.payload = output
          contract_stat
        end
      end
    end
  end
end
