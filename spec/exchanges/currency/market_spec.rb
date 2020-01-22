require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Currency::Market do
  it { expect(described_class::NAME).to eq 'currency' }
  it { expect(described_class::API_URL).to eq 'https://marketcap.backend.currency.com' }
end
