require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fisco::Market do
  it { expect(described_class::NAME).to eq 'fisco' }
  it { expect(described_class::API_URL).to eq 'https://api.fcce.jp/api/1' }
end
