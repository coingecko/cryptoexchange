require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dextop::Market do
  it { expect(described_class::NAME).to eq 'dextop' }
  it { expect(described_class::API_URL).to eq 'http://dex.top/v1' }
end
