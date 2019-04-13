require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chaince::Market do
  it { expect(described_class::NAME).to eq 'chaince' }
  it { expect(described_class::API_URL).to eq 'https://api.chaince.com' }
end
