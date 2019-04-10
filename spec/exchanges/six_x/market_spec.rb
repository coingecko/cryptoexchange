require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::SixX::Market do
  it { expect(described_class::NAME).to eq 'six_x' }
  it { expect(described_class::API_URL).to eq 'https://exapi.6x.com/exapi' }
end
