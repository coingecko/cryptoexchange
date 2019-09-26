module Cryptoexchange::Exchanges
  module BtseFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'btse_futures'
      API_URL = 'https://api.btse.com/futures/api/v1'

      def self.trade_page_url(args={})
        "https://www.btse.com/en/futures/#{args[:inst_id]}"
      end

      def self.calculate_contract_interval(start_date, end_date)
        return "perpetual" if start_date == "" && end_date == "" 
        contract_period = (end_date - start_date) / 60 / 60 / 24 / 30

        case contract_period
        when 1
          "monthly"
        when 3
          "quarterly"
        when 4
          "quarterly"
        end
      end
    end
  end
end
