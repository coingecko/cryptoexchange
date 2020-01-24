require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitibu::Market do
  it { expect(described_class::NAME).to eq 'bitibu' }
  it { expect(described_class::API_URL).to eq 'https://bitibu.com/api/v2' }
end
