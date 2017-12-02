require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbay::Market do
  it { expect(described_class::NAME).to eq 'bitbay' }
  it { expect(described_class::API_URL).to eq 'https://bitbay.net/API/Public' }
end
