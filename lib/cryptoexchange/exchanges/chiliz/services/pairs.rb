module Cryptoexchange::Exchanges
  module Chiliz
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Chiliz::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            if output["symbol"].include? "CHZ"
              base, target = Chiliz::Market.separate_symbol(output["symbol"])
              next if target == ""

              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Chiliz::Market::NAME,
              )    
            end
          end.compact
        end
      end
    end
  end
end
