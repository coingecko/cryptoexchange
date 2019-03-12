require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Stream365::Market do
  it { expect(described_class::NAME).to eq 'stream365' }
  it { expect(described_class::API_URL).to eq 'https://api.365.stream' }
end
