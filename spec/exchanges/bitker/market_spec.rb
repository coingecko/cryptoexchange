require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitker::Market do
  it { expect(described_class::NAME).to eq 'bitker' }
  it { expect(described_class::API_URL).to eq 'https://third.bitker.com/v1/api' }
end
