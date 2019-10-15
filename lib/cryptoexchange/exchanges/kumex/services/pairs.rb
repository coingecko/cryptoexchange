module Cryptoexchange::Exchanges
  module Kumex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Kumex::Market::API_URL}/contracts/active"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['data'].each do |data|
            base, target = data['baseCurrency'], data['quoteCurrency']
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                contract_interval: contract_type(data['type']),
                inst_id: data['symbol'],
                market: Kumex::Market::NAME
              )
          end
          pairs
        end

        def contract_type(type)
          if type == "FFWCSX"
            "perpetual"
          end
          # TODO: Futures not support yet by API or exchange, implement later
        end
      end
    end
  end
end
