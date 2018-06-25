module Cryptoexchange::Exchanges
  module Koinex
    module Services
      class GetSymbol
        def self.get_symbol(target_raw)
          if target_raw == 'bitcoin'
            target = 'BTC'
          elsif target_raw == 'ether'
            target = 'ETH'
          elsif target_raw == 'ripple'
            target = 'XRP'
          elsif target_raw == 'inr'
            target = target_raw.upcase
          end
          target
        end
      end
    end
  end
end
