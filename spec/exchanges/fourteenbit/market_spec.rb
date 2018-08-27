require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::FourteenBit::Market do
  it { expect(Cryptoexchange::Exchanges::FourteenBit::Market::NAME).to eq 'fourteenbit' }
  it { expect(Cryptoexchange::Exchanges::FourteenBit::Market::API_URL).to eq 'http://api-opay.com/api-application/modulos/cron/cotacao_moedas.php?view=dollar' }
end
