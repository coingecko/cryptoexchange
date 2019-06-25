require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::SatoWalletEx::Market do
  it { expect(described_class::NAME).to eq 'sato_wallet_ex' }
  it { expect(described_class::API_URL).to eq 'https://satowallet.com/Api' }
end
