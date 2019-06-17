module Cryptoexchange::Exchanges
  module KrakenFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['tickers'].map do |output|
            if output.key?("pair")
              base, target = output["pair"].split(":")
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: KrakenFutures::Market::NAME
              )              
            end
          end.compact
        end
      end
    end
  end
end
