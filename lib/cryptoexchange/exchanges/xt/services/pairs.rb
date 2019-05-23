module Cryptoexchange::Exchanges
  module Xt
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Xt::Market::API_URL}/tickers?isUseMarketName=true"

        def fetch
          output = super
          market_pairs = []
          output['datas'].each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Xt::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
