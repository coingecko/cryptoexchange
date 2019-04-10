module Cryptoexchange::Exchanges
  module Koinx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Koinx::Market::API_URL}/tickers"

        def fetch
          output = JSON.parse(HTTP.timeout(15).headers(accept: 'application/json').follow.get(PAIRS_URL))
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            if output[0].include?("/")
              base, target = output[0].split("/")
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Koinx::Market::NAME
              )
            end
          end.compact
        end
      end
    end
  end
end
