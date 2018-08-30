module Cryptoexchange::Exchanges
    module Fourteenbit
      class Market < Cryptoexchange::Models::Market
        NAME = 'fourteenbit'
        API_URL = 'http://api-opay.com/api-application/modulos/cron/cotacao_moedas.php?view=dollar'
      end
    end
  end
  