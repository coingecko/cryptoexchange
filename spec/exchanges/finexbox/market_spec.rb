require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitebtc::Market do
  it { expect(described_class::NAME).to eq 'finexbox' }
  it { expect(described_class::API_URL).to eq 'https://xapi.finexbox.com/v1' }
end
