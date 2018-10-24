require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitlish::Market do
  it { expect(described_class::NAME).to eq 'bitlish' }
  it { expect(described_class::API_URL).to eq 'https://bitlish.com/api/v1' }
end
