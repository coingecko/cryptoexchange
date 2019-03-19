require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dflow::Market do
  it { expect(described_class::NAME).to eq 'dflow' }
  it { expect(described_class::API_URL).to eq 'https://api.dflowx.com/v1' }
end
