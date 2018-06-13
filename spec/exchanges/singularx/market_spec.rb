require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Singularx::Market do
  it { expect(described_class::NAME).to eq 'singularx' }
  it { expect(described_class::API_URL).to eq 'https://cdn.singularx.com' }
end
