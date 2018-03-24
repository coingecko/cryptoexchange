require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paribu::Market do
  it { expect(described_class::NAME).to eq 'paribu' }
  it { expect(described_class::API_URL).to eq 'https://www.paribu.com/' }
end
