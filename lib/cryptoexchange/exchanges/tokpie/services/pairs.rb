module Cryptoexchange::Exchanges
  module Tokpie
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokpie::Market::API_URL}/api_ticker/"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(PAIRS_URL) do
            HTTP.get(PAIRS_URL, ssl_context: ctx).parse(:json)
          end
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            unless output["pair"].downcase.include?("stake")
              if output["isFrozen"] == 0
                base, target = output["pair"].split("@")
                Cryptoexchange::Models::MarketPair.new({
                  base: base,
                  target: target,
                  market: Tokpie::Market::NAME
                })
              end
            end
          end.compact
        end
      end
    end
  end
end
