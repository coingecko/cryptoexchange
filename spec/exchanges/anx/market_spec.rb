require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Anx::Market do
  it { expect(described_class::NAME).to eq 'anx' }
  it { expect(described_class::API_URL).to eq 'https://anxpro.com/api/2' }
end
