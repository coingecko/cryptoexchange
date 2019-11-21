module Cryptoexchange::Exchanges
  module Bitmex
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
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument?symbol=#{market_pair.inst_id}&count=100&reverse=true"
        end

        def adapt(output, market_pair)
          output = output.first
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Bitmex::Market::NAME
          contract_stat.open_interest = output['openInterest'].to_f
          contract_stat.index     = output['indicativeSettlePrice'].to_f
          contract_stat.index_identifier     = output['referenceSymbol'].gsub(".", "")
          contract_stat.index_name           = output['referenceSymbol']
          contract_stat.payload   = output

          expire_timestamp = output['expiry'] ? DateTime.parse(output['expiry']).to_time.to_i : nil
          start_timestamp = output['listing'] ? DateTime.parse(output['listing']).to_time.to_i : nil

          contract_stat.expire_timestamp = expire_timestamp
          contract_stat.start_timestamp = start_timestamp
          contract_stat.contract_type = contract_type(output['typ'])

          contract_stat.funding_rate_percentage = output['fundingRate'] ? output['fundingRate'] * 100 : nil
          contract_stat.next_funding_rate_timestamp = output['fundingTimestamp'] ? DateTime.parse(output['fundingTimestamp']).to_time.to_i : nil
          contract_stat.funding_rate_percentage_predicted = output['indicativeFundingRate'] ? output['indicativeFundingRate'] * 100 : nil

          contract_stat
        end

        def contract_type(instrument_type)
          if instrument_type == "FFWCSX"
            "perpetual"
          elsif instrument_type == "FFCCSX"
            "futures"
          elsif instrument_type == "OCECCS" || instrument_type == "OPECCS"
            "updown"
          end
        end
      end
    end
  end
end
