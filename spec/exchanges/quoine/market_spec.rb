require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Quoine::Market do
  it { expect(described_class::NAME).to eq 'quoine' }
  it { expect(described_class::API_URL).to eq 'https://api.quoine.com' }
end
