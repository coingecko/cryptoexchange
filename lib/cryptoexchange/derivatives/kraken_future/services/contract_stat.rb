module Cryptoexchange::Exchanges
  module KrakenFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(open_interest_url)
          adapt(output, market_pair)
        end

        def open_interest_url
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
        end

        def adapt(output, market_pair)
          data = output['tickers'].find {|i| i['symbol'] == market_pair.inst_id.downcase }
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = KrakenFutures::Market::NAME
          contract_stat.open_interest = data['openInterest'].to_f
          contract_stat.index     = data['markPrice'].to_f
          contract_stat.funding_rate = data['fundingRate'].to_f if data['fundingRate']
          # contract_stat.funding_rate_timestamp (pending)
          contract_stat.next_funding_rate_predicted = data['fundingRatePrediction'] if data['fundingRatePrediction']
          contract_stat.payload   = data
          contract_stat
        end
      end
    end
  end
end
