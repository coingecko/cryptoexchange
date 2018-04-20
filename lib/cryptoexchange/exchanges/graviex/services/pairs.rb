module Cryptoexchange::Exchanges
  module Graviex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs


        PAIRS_URL = "#{Cryptoexchange::Exchanges::Graviex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['name'].split("/")[0],
              target: market['name'].split("/")[1],
              market: Graviex::Market::NAME
            })
          end
        end

        def http_get(endpoint)
          ssl_context = OpenSSL::SSL::SSLContext.new
          ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
          fetch_response = HTTP.timeout(:write => 2, :connect => 15, :read => 18)
                             .follow.get(endpoint, ssl_context: ssl_context)
        end

#        def fetch
#          adapt(super)
#        end

#        def adapt(output)
#          output.map do |pair|
#            Cryptoexchange::Models::MarketPair.new(
#              base: pair[:base],
#              target: pair[:target],
#              market: Graviex::Market::NAME
#            )
#          end
#        end
      end
    end
  end
end

