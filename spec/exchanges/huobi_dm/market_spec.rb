require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiDm::Market do
  it { expect(described_class::NAME).to eq 'huobi_dm' }
  it { expect(described_class::API_URL).to eq 'https://api.hbdm.com' }
end
