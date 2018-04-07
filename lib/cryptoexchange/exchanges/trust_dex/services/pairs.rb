module Cryptoexchange::Exchanges
  module TrustDex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TrustDex::Market::API_URL}/return_ticket.php"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output.map do |pair|
            pair.each_key do |key|
              target, base = key.split("_")
              pairs << Cryptoexchange::Models::MarketPair.new({
                         base: base,
                         target: target,
                         market: TrustDex::Market::NAME
                       })
            end
          end
          
          pairs
        end
      end
    end
  end
end
