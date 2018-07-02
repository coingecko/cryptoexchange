require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Myspeedtrade::Market do
  it { expect(described_class::NAME).to eq 'myspeedtrade' }
  it { expect(described_class::API_URL).to eq 'https://myspeedtrade.com/api/v2' }
end
