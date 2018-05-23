require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinnox::Market do
  it { expect(described_class::NAME).to eq 'coinnox' }
  it { expect(described_class::API_URL).to eq 'https://coinnox.com/api/v2' }
end
