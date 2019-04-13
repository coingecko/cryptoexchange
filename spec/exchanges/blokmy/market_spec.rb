require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Blokmy::Market do
  it { expect(described_class::NAME).to eq 'blokmy' }
  it { expect(described_class::API_URL).to eq 'https://blokmy.com/api/v2' }
end
