require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitmax::Market do
  it { expect(described_class::NAME).to eq 'bitmax' }
  it { expect(described_class::API_URL).to eq 'https://bitmax.io/api/v1' }
end
