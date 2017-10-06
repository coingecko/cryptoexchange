require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Qryptos::Market do
  it { expect(described_class::NAME).to eq 'qryptos' }
  it { expect(described_class::API_URL).to eq 'https://api.qryptos.com' }
end
