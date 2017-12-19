module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Market < Cryptoexchange::Services::Market
        TARGETS = ['GBP', 'EUR', 'USD', 'CHF', 'ETH', 'BTC', 'JPY', 'LKK1Y', 'LKK2Y', 'LKK', 'ZAR', 'PLN', 'SEK', 'NOK', 'DILS', 'TRY',
'HKD', 'HUF', 'MXN', 'DKK', 'ELA', 'CZK', 'SGD', 'CAD']
        class << self

          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output, raw_response)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/Market"
        end

        def adapt_all(output, raw_response)
          output.map do |pair|
            pair_symbol = pair['assetPair']
            base, target = strip_pairs(pair_symbol)
            next unless base && target
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Lykke::Market::NAME
                          )
            adapt(pair, market_pair, raw_response)
          end
        end

        def adapt(pair_output, market_pair, raw_response)
        ticker           = Cryptoexchange::Models::Ticker.new
        ticker.base      = market_pair.base
        ticker.target    = market_pair.target
        ticker.market    = Lykke::Market::NAME
        ticker.bid       = NumericHelper.to_d(pair_output['bid'])
        ticker.ask       = NumericHelper.to_d(pair_output['ask'])
        ticker.last      = NumericHelper.to_d(pair_output['lastPrice'])
        ticker.volume    = NumericHelper.to_d(pair_output['volume24H'])
        ticker.timestamp = Time.now.to_i
        ticker.payload   = raw_response
        ticker
        end

        def strip_pairs(pair_symbol)

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
