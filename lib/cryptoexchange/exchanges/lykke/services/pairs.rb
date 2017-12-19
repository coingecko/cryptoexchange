module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/rate"
        TARGETS = ['GBP', 'EUR', 'USD', 'CHF', 'ETH', 'BTC', 'JPY', 'LKK1Y', 'LKK2Y', 'LKK', 'ZAR', 'PLN', 'SEK', 'NOK', 'DILS', 'TRY',
'HKD', 'HUF', 'MXN', 'DKK', 'ELA', 'CZK', 'SGD', 'CAD']

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            symbol = pair['id']
            base, target = strip_pairs(symbol)
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Lykke::Market::NAME
                            )
          end
          market_pairs
        end

        def strip_pairs(pair_symbol)
          #Match last 3 or 4 if it hits target
          last_4 = pair_symbol[-4..-1]
          last_3 = pair_symbol[-3..-1]
          last_5 = pair_symbol[-5..-1]


          if TARGETS.include? last_3
            base = pair_symbol[0..-4]
            target = last_3

          elsif TARGETS.include? last_4
              base = pair_symbol[0..-5]
              target = last_4

          elsif TARGETS.include? last_5
            base = pair_symbol[0..-6]
            target = last_5
          end
          [base, target]
        end

      end
    end
  end
end
