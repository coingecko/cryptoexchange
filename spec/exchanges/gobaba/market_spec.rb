require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gobaba::Market do
  it { expect(described_class::NAME).to eq 'gobaba' }
  it { expect(described_class::API_URL).to eq 'https://www.gobaba.com' }
end
