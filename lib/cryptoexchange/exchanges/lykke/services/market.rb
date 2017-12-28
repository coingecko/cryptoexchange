module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          market_classname = "Cryptoexchange::Exchanges::Lykke::Services::Pairs"
          market_class = Object.const_get(market_classname)
          market_pairs = market_class.new.fetch
          adapt_all(output, market_pairs)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/Market"
        end

        def adapt_all(output, market_pairs)
          output.map do |ticker|
            next unless market_pairs.any?{|match| "#{match.base + match.target}" == ticker["assetPair"]}
                pair_object = market_pairs.select{ |pair| "#{pair.base + pair.target}" == ticker["assetPair"]}
                base = pair_object[0].base
                target = pair_object[0].target
                market_pair = Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Lykke::Market::NAME
                              )
                adapt(ticker, market_pair)
          end
        end

        def adapt(ticker_output, market_pair)
        ticker           = Cryptoexchange::Models::Ticker.new
        ticker.base      = market_pair.base
        ticker.target    = market_pair.target
        ticker.market    = Lykke::Market::NAME
        ticker.bid       = NumericHelper.to_d(ticker_output['bid'])
        ticker.ask       = NumericHelper.to_d(ticker_output['ask'])
        ticker.last      = NumericHelper.to_d(ticker_output['lastPrice'])
        ticker.volume    = NumericHelper.to_d(ticker_output['volume24H'])
        ticker.timestamp = Time.now.to_i
        ticker.payload   = ticker_output
        ticker
        end
      end
    end
  end
end
