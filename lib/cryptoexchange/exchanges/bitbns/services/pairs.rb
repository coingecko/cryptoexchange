module Cryptoexchange::Exchanges
  module Bitbns
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbns::Market::API_URL}/order/getTickerWithVolume/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.keys.each do |symbol|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: symbol,
                              target: 'INR',
                              market: Bitbns::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
