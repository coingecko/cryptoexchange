require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitkonan::Market do
  it { expect(described_class::NAME).to eq 'bitkonan' }
  it { expect(described_class::API_URL).to eq 'https://bitkonan.com/api' }
end
