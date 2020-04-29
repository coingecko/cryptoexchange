module Cryptoexchange::Exchanges
  module SaturnNetwork
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/returnTicker.json"
        end

        def adapt_all(output)
          output.map do |pair|
            base = pair[1]["symbol"]
            target, contract_address = pair[0].split('_')

            # skip if it fetch old DGC coin
            next if contract_address == "0x7be3e4849aa2658c91b2d6fcf16ea88cfcb8b41e"
            
            if base == "NCOV"
              base = "#{base}-#{contract_address}"
            end
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: contract_address,
              market: SaturnNetwork::Market::NAME
            )
            adapt(pair, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = market_pair.inst_id
          ticker.market    = SaturnNetwork::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]["last"])
          ticker.high      = NumericHelper.to_d(output[1]["highestBid"])
          ticker.low       = NumericHelper.to_d(output[1]["lowestAsk"])
          ticker.volume    = NumericHelper.to_d(output[1]["quoteVolume"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
