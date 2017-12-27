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
          pairs_output = HTTP.get(dictionary_url)
          pairs_dictionary = JSON.parse(pairs_output.to_s)
          adapt_all(output, pairs_dictionary)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/Market"
        end

        def dictionary_url
          "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/dictionary"
        end

        def adapt_all(output, pairs_dictionary)
          output.each do |ticker|
              if pairs_dictionary.any?{|match| match["id"] == ticker["assetPair"]}
                pair_object = pairs_dictionary.select{|pair| pair["id"] == ticker["assetPair"]}
                base = pair_object[0]["baseAssetId"]
                target = pair_object[0]["quotingAssetId"]
              else
              end
              [base, target]
            next unless base && target
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
