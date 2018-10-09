require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Forkonex::Market do
  it { expect(described_class::NAME).to eq 'forkonex' }
  it { expect(described_class::API_URL).to eq 'https://api.forkonex.com/v2' }
end
