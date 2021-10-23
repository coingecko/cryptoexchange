require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Xcoex::Market do
  it { expect(described_class::NAME).to eq 'xcoex' }
  it { expect(described_class::API_URL).to eq 'https://live.xcoex.com:8443/api/v1/public' }
end
