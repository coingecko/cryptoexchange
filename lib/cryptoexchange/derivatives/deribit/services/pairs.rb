module Cryptoexchange::Exchanges
  module Deribit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Deribit::Market::NAME,
                              contract_interval: pair[:contract_interval],
                            )
          end
          market_pairs
        end
      end
    end
  end
end
