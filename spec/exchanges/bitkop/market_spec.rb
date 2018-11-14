require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitkop::Market do
  it { expect(described_class::NAME).to eq 'bitkop' }
  it { expect(described_class::API_URL).to eq 'https://apiv2.bitkop.com/Market' }
end
