require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ninecoin::Market do
  it { expect(described_class::NAME).to eq 'ninecoin' }
  it { expect(described_class::API_URL).to eq 'https://www.9coin.com/home/api' }
end
