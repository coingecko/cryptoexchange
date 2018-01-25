module Cryptoexchange::Exchanges
  module Cobinhood
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cobinhood::Market::API_URL}/market/trading_pairs"

        def fetch_via_api(endpoint = self.class::PAIRS_URL)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          fetch_response = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint, ssl_context: ctx)
          JSON.parse(fetch_response.to_s)
        end

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['result']["trading_pairs"]
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new \
              base: pair['base_currency_id'],
              target: pair['quote_currency_id'],
              market: Cobinhood::Market::NAME
          end
        end
      end
    end
  end
end
