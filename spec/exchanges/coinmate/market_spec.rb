require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinmate::Market do
  it { expect(described_class::NAME).to eq 'coinmate' }
  it { expect(described_class::API_URL).to eq 'https://coinmate.io/api' }
end
