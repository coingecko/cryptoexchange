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
          markets = output['markets']
          markets.map do |value|
            target, base = value['marketname'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: MercadoNiobioCash::Market::NAME
            )
          end
        end
      end
    end
  end
end