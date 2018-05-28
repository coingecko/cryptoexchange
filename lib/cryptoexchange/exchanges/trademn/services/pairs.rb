module Cryptoexchange::Exchanges
  module Trademn
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Trademn::Market::API_URL}/pairs"
        TARGETS = ['BTC', 'MNT', 'USD']

        def fetch
          output = super
          adapt(output['supported_pairs'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = strip_pairs(pair)
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Trademn::Market::NAME
                            )
          end
          market_pairs
        end

        def strip_pairs(pair_symbol)
        #Match last 3 against targets
          TARGETS.include? pair_symbol[-3..-1]
            base = pair_symbol[0..-4]
            target = pair_symbol[-3..-1]
          [base, target]
        end
      end
    end
  end
end
