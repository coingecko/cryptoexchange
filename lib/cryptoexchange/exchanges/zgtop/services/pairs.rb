module Cryptoexchange::Exchanges
  module Zgtop
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://www.zg.top/api/v2/market/coins"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['dataMap']['USDT'].map do |pair|
            base, target = pair['fname_sn'].split(' / ')
            Cryptoexchange::Models::MarketPair.new(
              inst_id: pair['fid'],
              base: base,
              target: target,
              market: Zgtop::Market::NAME
            )
          end
        end
      end
    end
  end
end
