module Cryptoexchange::Exchanges
  module Coinhe
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinhe::Market::API_URL}/currency-pair-summary?page_size=150"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["results"].map do |ticker|
            begin
              target = ticker["base"]["symbol"]
              base = ticker["pair"]["symbol"]
              Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Coinhe::Market::NAME
              )
            rescue StandardError
              nil
            end
          end.compact
        end
      end
    end
  end
end
