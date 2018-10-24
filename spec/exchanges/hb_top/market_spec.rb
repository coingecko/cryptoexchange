require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HbTop::Market do
  it { expect(described_class::NAME).to eq 'hb_top' }
  it { expect(described_class::API_URL).to eq 'https://api.hb.top/api/v1' }
end
