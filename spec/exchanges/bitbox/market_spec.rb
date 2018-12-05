require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbox::Market do
  it { expect(described_class::NAME).to eq 'bitbox' }
  it { expect(described_class::API_URL).to eq 'https://api.bitbox.me/trade/public/v2' }
end
