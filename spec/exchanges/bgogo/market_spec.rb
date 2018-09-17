require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bgogo::Market do
  it { expect(described_class::NAME).to eq 'bgogo' }
  it { expect(described_class::API_URL).to eq 'https://bgogo.com/api' }
end
