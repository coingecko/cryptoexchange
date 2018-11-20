require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitturk::Market do
  it { expect(described_class::NAME).to eq 'bitturk' }
  it { expect(described_class::API_URL).to eq 'https://api.bitturk.com/v1' }
end
