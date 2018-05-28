module Cryptoexchange::Exchanges
  module Vertpig
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vertpig::Market::API_URL}/public/getmarketsummaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pairs|
            target = pairs['MarketPairing']
            base   = pairs['MarketName'].gsub(/#{target}\z/, '')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Vertpig::Market::NAME)
          end
        end
      end
    end
  end
end
