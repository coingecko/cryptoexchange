module Cryptoexchange::Exchanges
  module KrakenFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

      end_time = 'https://www.cryptofacilities.com/derivatives/api/v3/instruments'
      funding_rate = 'https://www.cryptofacilities.com/derivatives/api/v3/tickers'

        def fetch(market_pair)
          output = super(open_interest_url)
          contract_info = get_contract_info(market_pair)
          adapt(output, contract_info, market_pair)
        end

        def get_contract_info(market_pair)
          url = if market_pair.contract_interval == "perpetual"
                  "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
                else
                  "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/instruments"
                end
          contract_info = HTTP.get(url).parse(:json)
          process_contract_info(contract_info, market_pair)
        end

        def process_contract_info(contract_info, market_pair)
          arr = {}
          if market_pair.contract_interval == "perpetual"
            contract = contract_info['tickers'].find { |i| i['symbol'] == market_pair.inst_id.downcase }
            arr["funding_rate_percentage"] = contract["fundingRate"].to_f * 1000000
            arr["funding_rate_percentage_predicted"] = contract["fundingRatePrediction"].to_f * 1000000
            arr["next_funding_timestamp"] = nil
          else
            contract = contract_info['instruments'].find { |i| i["symbol"] == market_pair.inst_id.downcase }
            arr["expire_timestamp"] = DateTime.parse(contract["lastTradingTime"]).to_time.to_i
            arr["start_timestamp"] = nil
          end
          arr
        end

        def open_interest_url
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"
        end

        def adapt(output, contract_info, market_pair)
          data = output['tickers'].find {|i| i['symbol'] == market_pair.inst_id.downcase }
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = KrakenFutures::Market::NAME
          contract_stat.open_interest = data['openInterest'].to_f
          contract_stat.index     = data['markPrice'].to_f

          contract_stat.expire_timestamp = contract_info['expire_timestamp']
          contract_stat.start_timestamp = contract_info['start_timestamp']
          contract_stat.contract_type = contract_type(contract_stat.expire_timestamp)

          contract_stat.funding_rate_percentage = contract_info['funding_rate_percentage']
          contract_stat.next_funding_rate_timestamp = contract_info['next_funding_timestamp']
          contract_stat.funding_rate_percentage_predicted = contract_info['funding_rate_percentage_predicted']

          contract_stat.payload   = data
          contract_stat
        end

        def contract_type(expire)
          if expire.nil?
            "perpetual"
          else
            "futures"
          end
        end
      end
    end
  end
end
