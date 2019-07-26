module Cryptoexchange::Exchanges
  module Ethfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ethfinex::Market::API_URL}/v2/tickers?symbols=ALL"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            pair = pair[0]

            next if pair[0] != 't'

            if pair.include? ":"
              base, target = pair.split(":")
            else
              base = pair[1..pair.length - 4]
              target = pair[-3..-1]
            end

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Ethfinex::Market::NAME
            )
          end
        end
      end
    end
  end
end
