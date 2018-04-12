module Cryptoexchange::Exchanges
  module MercadoNiobioCash
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::MercadoNiobioCash::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['data'].keys.each do |base|
            next if base == 'date'
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: NBR,
                target: 'BRL',
                market: MercadoNiobioCash::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
