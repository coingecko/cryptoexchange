module Cryptoexchange::Exchanges
  module CryTrex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CryTrex::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["result"].map do |output|
            Cryptoexchange::Models::MarketPair.new(
              base: output["Currency"],
              target: output["Market"],
              market: CryTrex::Market::NAME
            )
          end
        end
      end
    end
  end
end
