require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Wcx::Market do
  it { expect(described_class::NAME).to eq 'wcx' }
  it { expect(described_class::API_URL).to eq 'https://api.wcex.com' }
end
