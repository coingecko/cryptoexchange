require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Szzc::Market do
  it { expect(described_class::NAME).to eq 'szzc' }
  it { expect(described_class::API_URL).to eq 'https://szzc.com/api/public' }
end
