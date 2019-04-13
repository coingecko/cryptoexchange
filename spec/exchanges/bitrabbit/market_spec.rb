require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitrabbit::Market do
  it { expect(described_class::NAME).to eq 'bitrabbit' }
  it { expect(described_class::API_URL).to eq 'https://bitrabbit.com/web' }
end
