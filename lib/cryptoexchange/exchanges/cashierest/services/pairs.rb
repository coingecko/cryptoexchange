module Cryptoexchange::Exchanges
  module Cashierest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/tickerall"

        def fetch
          raw_output = HTTP.get("#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/tickerall")
          string = raw_output.body.to_s.force_encoding("UTF-8").sub("\uFEFF", "")
          output = JSON.parse(string)
          adapt(output['Cashierest'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            if pair[1]['isFrozen'] == "0"
              base, target = pair[0].split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Cashierest::Market::NAME
                              )
            end
           end
          market_pairs
        end
      end
    end
  end
end
