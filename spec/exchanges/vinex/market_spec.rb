require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vinex::Market do
  it { expect(described_class::NAME).to eq 'vinex' }
  it { expect(described_class::API_URL).to eq 'https://api.vinex.network/api/v2' }
end
