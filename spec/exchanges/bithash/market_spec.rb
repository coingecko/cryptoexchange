require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bithash::Market do
  it { expect(described_class::NAME).to eq 'bithash' }
  it { expect(described_class::API_URL).to eq 'https://www.bithash.net/api' }
end
