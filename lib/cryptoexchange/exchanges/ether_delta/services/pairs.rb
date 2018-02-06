module Cryptoexchange::Exchanges
  module EtherDelta
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::EtherDelta::Market::API_URL}/returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output.each do |key, value|
            target, base = key.split('_')
            base = TokenHelper.get_symbol(value['tokenAddr']) if base =~ /\s/ || base =~ /0x/
            # pairs << base
            pairs << Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: EtherDelta::Market::NAME
            })
          end
          pairs
        end
      end
    end
  end
end
