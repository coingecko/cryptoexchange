require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Mxc::Market do
  it { expect(described_class::NAME).to eq 'mxc' }
  it { expect(described_class::API_URL).to eq 'https://www.mxc.com/open/api/v1' }
end
