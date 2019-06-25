require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitsdaq::Market do
  it { expect(described_class::NAME).to eq 'bitsdaq' }
  it { expect(described_class::API_URL).to eq 'https://bitsdaq.com/api' }
end
