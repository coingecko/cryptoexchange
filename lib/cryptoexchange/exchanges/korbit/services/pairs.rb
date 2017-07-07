module Cryptoexchange::Exchanges
  module Korbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        # NOTE: https://apidocs.korbit.co.kr/#detailed-ticker
        # From Korbit doc
        # As our BETA service, you can also specify “etc_krw” for
        # Ethereum Classic trading, “eth_krw” for Ethereum trading,
        # and “xrp_krw” for Ripple trading.
        # Coins other than BTC, ETC, ETH, XRP are not supported yet.
        def fetch
          supported_pairs = [
            { base: 'BTC', target: 'KRW' },
            { base: 'ETH', target: 'KRW' },
            { base: 'ETC', target: 'KRW' },
          ]
          market_pairs = []
          supported_pairs.each do |pair|
            market_pairs << Korbit::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: Korbit::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
