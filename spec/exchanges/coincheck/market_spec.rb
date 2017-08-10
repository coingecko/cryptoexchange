require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coincheck::Market do
  it { expect(described_class::NAME).to eq 'coincheck' }
  it { expect(described_class::API_URL).to eq 'https://coincheck.com/api' }
end
