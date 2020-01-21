module Cryptoexchange::Exchanges
  module Bancor
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/exchanges?platform=bancor&key=#{Cryptoexchange::Exchanges::Bancor::Market.api_key}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['results'].map do |ticker|
            next if ticker["tokenSymbol"] == nil || ticker["baseSymbol"] == nil
            Cryptoexchange::Models::MarketPair.new(
              base: ticker["tokenSymbol"],
              target: ticker["baseSymbol"],
              market: Bancor::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
