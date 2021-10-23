# don't add trade first, it returns last year data

# module Cryptoexchange::Exchanges
#   module Nominex
#     module Services
#       class Trades < Cryptoexchange::Services::Market
#         def fetch(market_pair)
#           output = super(ticker_url(market_pair))
#           adapt(output, market_pair)
#         end

#         def ticker_url(market_pair)
#           base   = market_pair.base
#           target = market_pair.target
#           "#{Cryptoexchange::Exchanges::Nominex::Market::API_URL}/trades/#{base}/#{target}"
#         end

#         def adapt(output, market_pair)
#           output['items'].collect do |trade|
#             tr = Cryptoexchange::Models::Trade.new
#             tr.trade_id  = trade["id"]
#             tr.base      = market_pair.base
#             tr.target    = market_pair.target
#             tr.market    = Nominex::Market::NAME
#             tr.type      = trade['side'].downcase
#             tr.price     = trade['price']
#             tr.amount    = trade['amount']
#             tr.timestamp = trade['timestamp'].to_i / 1000
#             tr.payload   = trade
#             tr
#           end
#         end
#       end
#     end
#   end
# end
