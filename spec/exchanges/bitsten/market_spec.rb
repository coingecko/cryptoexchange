require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitsten::Market do
  it { expect(described_class::NAME).to eq 'bitsten' }
  it { expect(described_class::API_URL).to eq 'https://bitsten.com/api/v1' }
end
