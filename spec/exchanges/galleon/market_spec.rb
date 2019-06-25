require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Galleon::Market do
  it { expect(described_class::API_URL).to eq 'https://galleon.exchange/api/v2' }
end
