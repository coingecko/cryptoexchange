require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptagio::Market do
  it { expect(described_class::NAME).to eq 'cryptagio' }
  it { expect(described_class::API_URL).to eq 'https://peatio.cryptagio.com/api/v2' }
end
