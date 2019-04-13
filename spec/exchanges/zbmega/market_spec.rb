require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zbmega::Market do
  it { expect(described_class::NAME).to eq 'zbmega' }
  it { expect(described_class::API_URL).to eq 'https://www.zbm.com/api/v1/ticker/all' }
end
