require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbegin::Market do
  it { expect(described_class::NAME).to eq 'bitbegin' }
  it { expect(described_class::API_URL).to eq 'https://bitbegin.io/api' }
end
