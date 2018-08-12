require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Satowallet::Market do
  it { expect(described_class::NAME).to eq 'satowallet' }
  it { expect(described_class::API_URL).to eq 'https://satowallet.com' }
end
