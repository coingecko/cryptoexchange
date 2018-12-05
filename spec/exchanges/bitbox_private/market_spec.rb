require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitboxPrivate::Market do
  it { expect(described_class::NAME).to eq 'bitbox_private' }
  it { expect(described_class::API_URL).to eq 'https://openapi.bitbox.me' }
end
