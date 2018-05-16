require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Koinok::Market do
  it { expect(described_class::NAME).to eq 'koinok' }
  it { expect(described_class::API_URL).to eq 'https://www.koinok.com/api/brain' }
end
