module Cryptoexchange::Exchanges
  module Dydx
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super market_pairs_url
          output['markets'].map do |pair, value|
            base, target = pair.split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Dydx::Market::NAME
            )

            contract_type = get_contract_type(value['type'])
            contract_info_url = contract_info_url(market_pair, contract_type)
            next if !contract_info_url
            contract_info = super(contract_info_url)

            adapt(market_pair, contract_type, contract_info['market'])
          end.compact
        end

        def market_pairs_url
          Cryptoexchange::Exchanges::Dydx::Services::Pairs::PAIRS_URL
        end

        def contract_info_url(market_pair, contract_type)
          if contract_type == "perpetual"
              "#{Cryptoexchange::Exchanges::Dydx::Market::API_URL}/perpetual-markets/#{market_pair.base}-#{market_pair.target}"
          else
            #TODO
            nil
          end
        end

        def adapt(market_pair, contract_type, contract_info)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Dydx::Market::NAME
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          contract_stat.funding_rate_percentage = contract_info['fundingRate'] ? contract_info['fundingRate'] * 100 : nil
          contract_stat.open_interest = contract_info['openInterest'].to_f
          # contract_stat.index
          # contract_stat.next_funding_rate_timestamp
          # contract_stat.funding_rate_percentage_predicted
          contract_stat.contract_type = contract_type
          contract_stat.payload = {
            'open_interest': contract_stat.open_interest,
            'funding_rate_percentage': contract_stat.funding_rate_percentage
          }

          contract_stat
        end

        def get_contract_type(type)
          if type == "PERPETUAL"
            "perpetual"
          elsif type == "SPOT"
            "spot"
          end
        end
      end
    end
  end
end
