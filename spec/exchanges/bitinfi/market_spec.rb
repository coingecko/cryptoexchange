require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitinfi::Market do
  it { expect(described_class::NAME).to eq 'bitinfi' }
  it { expect(described_class::API_URL).to eq 'https://hq.bitinfi.com/v1' }
end
