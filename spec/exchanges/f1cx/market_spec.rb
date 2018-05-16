require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::F1cx::Market do
  it { expect(described_class::NAME).to eq 'f1cx' }
  it { expect(described_class::API_URL).to eq 'https://f1cx.com/api/v2' }
end
