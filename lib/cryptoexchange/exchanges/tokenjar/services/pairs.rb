module Cryptoexchange::Exchanges
  module Tokenjar
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokenjar::Market::API_URL}/ticker"

        def fetch
          raw_output = HTTP.get("#{PAIRS_URL}")
          output = JSON.parse(raw_output)
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            if pair[1]['isFrozen'] == "0"
              base, target = pair[0].gsub(' ', '').split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Tokenjar::Market::NAME
                              )
            end
           end
          market_pairs
        end
      end
    end
  end
end
