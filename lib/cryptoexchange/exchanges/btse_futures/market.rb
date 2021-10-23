module Cryptoexchange::Exchanges
  module BtseFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'btse_futures'
      API_URL = 'https://api.btse.com/futures/api/v1'

      def self.trade_page_url(args={})
        "https://www.btse.com/en/futures/#{args[:inst_id]}"
      end

      def self.calculate_contract_interval(start_date, end_date)
        if start_date == "" && end_date == "" 
          "perpetual"
        else
          "futures"
        end
      end
    end
  end
end
