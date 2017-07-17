require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitflyer::Market do
  it { expect(described_class::NAME).to eq 'bitflyer' }
  it { expect(described_class::API_URL).to eq 'https://api.bitflyer.jp/v1/' }
end
