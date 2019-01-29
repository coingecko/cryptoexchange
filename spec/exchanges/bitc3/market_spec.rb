require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitc3::Market do
  it { expect(described_class::NAME).to eq 'bitc3' }
  it { expect(described_class::API_URL).to eq 'https://www.bitc3.com/public' }
end
