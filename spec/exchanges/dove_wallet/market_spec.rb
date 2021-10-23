require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DoveWallet::Market do
  it { expect(described_class::NAME).to eq 'dove_wallet' }
  it { expect(described_class::API_URL).to eq 'https://api.dovewallet.com/v1/public' }
end
