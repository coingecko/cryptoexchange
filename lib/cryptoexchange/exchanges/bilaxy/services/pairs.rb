module Cryptoexchange::Exchanges
  module Bilaxy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bilaxy::Market::PAIRS_API_URL}"

        def fetch
          output = super
          output['dataMap'].map do |target, symbol|
            symbol.map do |base_info|
              Cryptoexchange::Models::Bilaxy::MarketPair.new(
                base:   base_info['fShortName'],
                target: target,
                id:     base_info['fid'],
                market: Bilaxy::Market::NAME
              )
            end
          end.flatten
        end
      end
    end
  end
end
