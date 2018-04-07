require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::SouthXchange::Market do
  it { expect(described_class::NAME).to eq 'south_xchange' }
  it { expect(described_class::API_URL).to eq 'https://www.southxchange.com/api' }
end
