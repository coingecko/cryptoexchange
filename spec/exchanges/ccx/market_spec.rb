require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ccx::Market do
  it { expect(described_class::NAME).to eq 'ccx' }
  it { expect(described_class::API_URL).to eq 'https://manager.ccxcanada.com/api/v2' }
end
