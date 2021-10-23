require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitfex::Market do
  it { expect(described_class::NAME).to eq 'bitfex' }
  it { expect(described_class::API_URL).to eq 'https://bitfex.trade' }
end
