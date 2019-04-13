module Cryptoexchange::Exchanges
  module Cybex
    class Market < Cryptoexchange::Models::Market
      NAME            = 'cybex'
      API_URL         = 'https://hongkong.cybex.io'
      USED_GATEWAY    = 'JADE'
      OMITTED_GATEWAY = 'JAMES'

      class << self
        def prepend_symbol_prefix(pair)
          base   = pair.base == 'CYB' ? pair.base : "#{USED_GATEWAY}.#{pair.base}"
          target = pair.target == 'CYB' ? pair.target : "#{USED_GATEWAY}.#{pair.target}"
          [base, target]
        end
      end
    end
  end
end
