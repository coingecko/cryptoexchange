require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptaldash::Market do
  it { expect(described_class::NAME).to eq 'cryptaldash' }
  it { expect(described_class::API_URL).to eq 'https://api.cryptaldash.com/v1' }
end
