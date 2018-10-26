require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zeniex::Market do
  it { expect(described_class::NAME).to eq 'zeniex' }
  it { expect(described_class::API_URL).to eq 'https://openapi.zeniex.com' }
end
