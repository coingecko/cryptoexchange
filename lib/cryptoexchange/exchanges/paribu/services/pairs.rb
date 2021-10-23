module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paribu::Market::API_URL}/ticker"

        def fetch
          output = super
          output.keys.map do |pair|
            base, target = pair.split("_")
            inst_id = "#{base}_#{target}".downcase
            # set target to TRY because CryptoExchangeRate::SUPPORTED_STANDARD_CURRENCIES not support TL
            target = if target == "TL"
                       "TRY"
                     else
                       target
                     end

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: inst_id,
              market: Paribu::Market::NAME
            )
          end
        end
      end
    end
  end
end
