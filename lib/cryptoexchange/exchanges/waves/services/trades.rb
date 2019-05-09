# We'll stop supporting trades for waves platform until further notice

# module Cryptoexchange::Exchanges
#   module Waves
#     module Services
#       class Trades < Cryptoexchange::Services::Market
#         def fetch(market_pair)
#           output = super(ticker_url(market_pair))
#           adapt(output, market_pair)
#         end
#
#         def ticker_url(market_pair)
#           "#{Cryptoexchange::Exchanges::Waves::Market::API_URL}/trades/#{market_pair.base}/#{market_pair.target}/100"
#         end
#
#         def adapt(output, market_pair)
#           output.collect do |trade|
#             tr           = Cryptoexchange::Models::Trade.new
#             tr.trade_id  = trade['id']
#             tr.base      = market_pair.base
#             tr.target    = market_pair.target
#             tr.type      = trade['type']
#             tr.price     = trade['price']
#             tr.amount    = trade['amount']
#             tr.timestamp = trade['timestamp'] / 1000
#             tr.payload   = trade
#             tr.market    = Waves::Market::NAME
#             tr
#           end
#         end
#       end
#     end
#   end
# end
