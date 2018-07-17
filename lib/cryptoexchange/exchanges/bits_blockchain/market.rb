module Cryptoexchange::Exchanges
  module BitsBlockchain
    class Market < Cryptoexchange::Models::Market
      NAME = 'bits_blockchain'
      API_URL = 'https://www.bitsblockchain.net/api/v1'
    end
  end
end
