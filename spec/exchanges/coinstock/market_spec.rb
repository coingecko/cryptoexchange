require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinstock::Market do
  it { expect(described_class::NAME).to eq 'coinstock' }
  it { expect(described_class::API_URL).to eq 'https://coinstock.me/api/v2' }
end
