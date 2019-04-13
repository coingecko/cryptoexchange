require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinbe::Market do
  it { expect(described_class::NAME).to eq 'coinbe' }
  it { expect(described_class::API_URL).to eq 'https://coinbe.net/public' }
end
