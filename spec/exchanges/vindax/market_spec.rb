require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vindax::Market do
  it { expect(described_class::NAME).to eq 'vindax' }
  it { expect(described_class::API_URL).to eq 'https://api.vindax.com/api/v1/returnTicker' }
end
