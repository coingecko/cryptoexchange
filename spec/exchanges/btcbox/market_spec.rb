require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcbox::Market do
  it { expect(described_class::NAME).to eq 'btcbox' }
  it { expect(described_class::API_URL).to eq 'https://www.btcbox.co.jp/api/v1' }
end
