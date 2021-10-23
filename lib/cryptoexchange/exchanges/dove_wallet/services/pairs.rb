module Cryptoexchange::Exchanges
  module DoveWallet
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DoveWallet::Market::API_URL}/getmarketsummaries"

        def fetch
          output = super
          adapt(output['result'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|
            target, base = value["MarketName"].split("-")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: DoveWallet::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
