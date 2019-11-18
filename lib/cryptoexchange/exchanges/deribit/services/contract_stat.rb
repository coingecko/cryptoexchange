module Cryptoexchange::Exchanges
  module Deribit
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url(market_pair))
          index = super(index_url(market_pair))
          contract_info = get_contract_info(market_pair)
          adapt(open_interest, index, contract_info, market_pair)
        end

        def get_contract_info(market_pair)
          book_summary_url = "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_book_summary_by_instrument?instrument_name=#{market_pair.inst_id}&kind=#{market_pair.contract_interval}"
          instrument_url = "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_instruments?currency=#{market_pair.base}&kind=#{market_pair.contract_interval}&expired=false"
          book_summary = HTTP.get(book_summary_url).parse(:json)
          instrument = HTTP.get(instrument_url).parse(:json)
          process_contract_info(book_summary, instrument, market_pair)
        end

        def process_contract_info(book_summary, instrument, market_pair)
          contract = instrument['result'].find { |i| i["instrument_name"] == market_pair.inst_id }
          arr = {}
          arr["strike"] = contract["strike"]
          arr["option_type"] = contract["option_type"]
          arr["kind"] = contract["kind"]
          arr["settlement_period"] = contract["settlement_period"]
          
          if arr["settlement_period"] == "perpetual"
            arr["funding_rate_percentage"] = book_summary["result"][0]["funding_8h"].to_f * 100
            arr["expire_timestamp"] = nil
            arr["start_timestamp"] = nil
          else
            arr["funding_rate_percentage"] = nil
            arr["expire_timestamp"] = contract["expiration_timestamp"].to_i / 1000 if contract["expiration_timestamp"]
            arr["start_timestamp"] = contract["creation_timestamp"].to_i / 1000 if contract["creation_timestamp"]
          end
          

          # if market_pair.contract_interval == "perpetual"
          #   arr["funding_rate_percentage"] = contract_info["result"][0]["funding_8h"].to_f * 100
          #   arr["funding_rate_percentage_predicted"] = nil
          #   arr["next_funding_timestamp"] = nil
          #   arr["kind"] = "future"
          #   arr["settlement_period"] = "pereptual"
          # elsif market_pair.contract_interval == "option"
          #   contract = instrument['result'].find { |i| i["instrument_name"] == market_pair.inst_id }
          #   arr["strike"] = contract["strike"]
          #   arr["option_type"] = contract["option_type"]
          #   arr["kind"] = contract["kind"]
          #   arr["settlement_period"] = contract["settlement_period"]
          # elsif market_pair.contract_interval == "future"
          #   contract = instrument['result'].find { |i| i["instrument_name"] == market_pair.inst_id }
          
          #   arr["kind"] = contract["kind"]
          #   arr["settlement_period"] = contract["settlement_period"]
          # end
          arr
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_book_summary_by_instrument?instrument_name=#{market_pair.inst_id}&kind=#{market_pair.contract_interval}"
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_index?currency=#{market_pair.base}"
        end

        def adapt(open_interest, index, contract_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Deribit::Market::NAME
          contract_stat.open_interest = open_interest['result'][0]['open_interest'].to_f
          contract_stat.index     = index['result'][market_pair.base].to_f
          contract_stat.index_identifier = "Deribit-#{market_pair.base}"
          contract_stat.index_name = "Deribit #{market_pair.base}"

          contract_stat.expire_timestamp = contract_info['expire_timestamp']
          contract_stat.start_timestamp = contract_info['start_timestamp']
          contract_stat.contract_type = contract_type(contract_info['kind'], contract_info['settlement_period'])

          contract_stat.option_type = contract_info['option_type']
          contract_stat.strike = contract_info['strike']

          contract_stat.funding_rate_percentage = contract_info['funding_rate_percentage']
          contract_stat.next_funding_rate_timestamp = contract_info['next_funding_timestamp']
          contract_stat.funding_rate_percentage_predicted = contract_info['funding_rate_percentage_predicted']
          contract_stat.payload   = { "open_interest" => open_interest, "index" => index, "contract_info" => contract_info }
          contract_stat
        end

        def contract_type(kind, settlement_period)
          if kind == "future" && settlement_period == "perpetual"
            "perpetual"
          elsif kind == "future" && settlement_period != "perpetual"
            "futures"
          elsif kind == "option"
            "options"
          end
        end
      end
    end
  end
end
