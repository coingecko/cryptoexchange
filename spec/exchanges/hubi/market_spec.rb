require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hubi::Market do
  it { expect(described_class::NAME).to eq 'hubi' }
  it { expect(described_class::API_URL).to eq 'https://www.hubi.com/api/v1' }
end
