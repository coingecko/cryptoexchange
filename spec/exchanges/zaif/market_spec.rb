require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zaif::Market do
  it { expect(described_class::NAME).to eq 'zaif' }
  it { expect(described_class::API_URL).to eq 'https://api.zaif.jp/api/1' }
end
