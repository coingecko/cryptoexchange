require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bancor::Market do
  it { expect(described_class::NAME).to eq 'bancor' }
  it { expect(described_class::API_URL).to eq 'http://api.blocklytics.org/pools/v0' }
end
