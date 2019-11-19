require 'byebug'
module Cryptoexchange::Exchanges
  module Cashierest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/TickerAll"

        def fetch
          encoding_options = {
            :invalid           => :replace,  # Replace invalid byte sequences
            :undef             => :replace,  # Replace anything not defined in ASCII
            :replace           => '',        # Use a blank for those replacements
            :universal_newline => true       # Always break lines with \n
          }
          output = HTTP.get(PAIRS_URL)
          output = JSON.parse(JSON.parse(output.to_json.encode(Encoding.find('ASCII'), encoding_options)))
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
