require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Crxzone::Market do
  it { expect(described_class::NAME).to eq 'crxzone' }
  it { expect(described_class::API_URL).to eq 'https://www.crxzone.com/API' }
end
