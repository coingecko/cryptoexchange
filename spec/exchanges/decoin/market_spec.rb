require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Decoin::Market do
  it { expect(described_class::NAME).to eq 'decoin' }
  it { expect(described_class::API_URL).to eq 'https://apiv1.decoin.io' }
end
