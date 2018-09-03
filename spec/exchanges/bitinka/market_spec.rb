require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitinka::Market do
  it { expect(described_class::NAME).to eq 'bitinka' }
  it { expect(described_class::API_URL).to eq 'https://www.bitinka.com/api/apinka' }
end
