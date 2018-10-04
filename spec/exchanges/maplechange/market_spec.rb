require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Maplechange::Market do
  it { expect(described_class::NAME).to eq 'maplechange' }
  it { expect(described_class::API_URL).to eq 'https://maplechange.com/api/v2' }
end
