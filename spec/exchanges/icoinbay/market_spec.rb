require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Icoinbay::Market do
  it { expect(described_class::NAME).to eq 'icoinbay' }
  it { expect(described_class::API_URL).to eq 'http://api.icoinbay.com/api' }
end
