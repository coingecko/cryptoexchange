module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitfinex::Market::API_URL}/symbols"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            if pair.include? ":"
              base, target = pair.split(":")
            else
              base = pair[0..pair.length - 4]
              target = pair[-3..-1]
            end
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitfinex::Market::NAME
            )
          end
        end
      end
    end
  end
end
