require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gdax::Market do
  it { expect(described_class::NAME).to eq 'gdax' }
  it { expect(described_class::API_URL).to eq 'https://api.gdax.com' }
end
