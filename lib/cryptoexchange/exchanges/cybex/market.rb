module Cryptoexchange::Exchanges
  module Cybex
    class Market
      NAME            = 'cybex'
      API_URL         = 'https://beijing.51nebula.com'
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
