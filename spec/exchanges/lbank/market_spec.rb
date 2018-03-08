require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Lbank::Market do
  it { expect(described_class::NAME).to eq 'lbank' }
  it { expect(described_class::API_URL).to eq 'https://api.lbank.info/v1' }
end
