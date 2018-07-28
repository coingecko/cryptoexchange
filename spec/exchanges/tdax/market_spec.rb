require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tdax::Market do
  it { expect(described_class::NAME).to eq 'tdax' }
  it { expect(described_class::API_URL).to eq 'https://api.tdax.com' }
end
