module Cryptoexchange::Exchanges
  module BitzFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            # set to bulk process to save requests
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BitzFutures::Market::API_URL}/Market/getContractTickers"
        end

        def adapt_all(output)
          output["data"].map do |pair|
            base, target = pair['pair'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: pair['contractId'],
                            contract_interval: "perpetual",
                            market: BitzFutures::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.inst_id = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.market = BitzFutures::Market::NAME
          ticker.last = NumericHelper.to_d(output['latest'])
          ticker.high = NumericHelper.to_d(output['max'])
          ticker.low = NumericHelper.to_d(output['min'])
          ticker.volume = NumericHelper.to_d(output['baseAmount'].split(" ").first)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
