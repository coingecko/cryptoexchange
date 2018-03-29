require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bit2c::Market do
  it { expect(described_class::NAME).to eq 'bit2c' }
  it { expect(described_class::API_URL).to eq 'https://bit2c.co.il' }
end
