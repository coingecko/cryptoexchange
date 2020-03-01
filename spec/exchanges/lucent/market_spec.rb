require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Lucent::Market do
  it { expect(described_class::NAME).to eq 'lucent' }
  it { expect(described_class::API_URL).to eq 'https://lucent.exchange/api/v2' }
end
