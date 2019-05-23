require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Floatsv::Market do
  it { expect(described_class::NAME).to eq 'floatsv' }
  it { expect(described_class::API_URL).to eq 'https://www.floatsv.com/api' }
end
