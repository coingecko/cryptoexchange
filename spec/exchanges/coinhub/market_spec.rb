require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinhub::Market do
  it { expect(described_class::NAME).to eq 'coinhub' }
  it { expect(described_class::API_URL).to eq 'https://www.coinhub.io/en/gateway' }
end
