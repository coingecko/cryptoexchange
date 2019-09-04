module Cryptoexchange::Exchanges
  module Cashierest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/TickerAll"

        def fetch
          #remove BOM from json 
          output = JSON.parse(HTTP.get(PAIRS_URL).to_s.gsub!("\xEF\xBB\xBF".force_encoding("UTF-8"), ''))
          output["Cashierest"].map do |output, ticker|
            if ticker["isFrozen"] == "0"
              target, base = output.split('_')
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Cashierest::Market::NAME
              )
            end
          end
        end
      end
    end
  end
end
