module Cryptoexchange::Exchanges
  module BtseFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          # need to add key for client match the correct ticker
          output = output.each do |o|
                     o.merge!(base: o["symbol"].chomp("PFC"), target: "USD", contract_interval: "Perpetual")
                   end
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BtseFutures::Market::API_URL}/market_summary"
        end

        def adapt_all(output)
          output.map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new({
                            base: ticker[:base],
                            target: ticker[:target],
                            inst_id: ticker["symbol"],
                            contract_interval: ticker[:contract_interval],
                            market: BtseFutures::Market::NAME
                          })
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.market = BtseFutures::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.ask = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid = NumericHelper.to_d(output['highestBid'])
          ticker.high = NumericHelper.to_d(output['high24Hr'])
          ticker.low = NumericHelper.to_d(output['low24Hr'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.change = NumericHelper.to_d(output['percentageChange'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
