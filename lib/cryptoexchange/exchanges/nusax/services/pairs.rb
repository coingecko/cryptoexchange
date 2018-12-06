# require 'pry'

module Cryptoexchange::Exchanges
  module Nusax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nusax::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          pairs = output.map{|pair| pair["name"]}
          pairs.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair.split("/")[0],
                              target: pair.split("/")[1],
                              market: Nusax::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
