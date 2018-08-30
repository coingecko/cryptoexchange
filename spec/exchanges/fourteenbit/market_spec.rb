require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fourteenbit::Market do
  it { expect(described_class::NAME).to eq 'fourteenbit' }
  it { expect(described_class::API_URL).to eq 'http://api-opay.com/api-application/modulos/cron/cotacao_moedas.php?view=dollar' }
end

