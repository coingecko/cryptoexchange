require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Liqnet::Market do
  it { expect(described_class::NAME).to eq 'liqnet' }
  it { expect(described_class::API_URL).to eq 'https://api.liqnet.com/public/rest' }
end
