require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Crytrex::Market do
  it { expect(described_class::NAME).to eq 'crytrex' }
  it { expect(described_class::API_URL).to eq 'https://cryt.crytrex.com/public_api' }
end
