require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::MercadoBitcoin::Market do
  it { expect(described_class::NAME).to eq 'mercado_bitcoin' }
  it { expect(described_class::API_URL).to eq 'https://www.mercadobitcoin.net/api' }
end
