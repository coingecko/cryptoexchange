require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TuxExchange::Market do
  it { expect(described_class::NAME).to eq 'tux_exchange' }
  it { expect(described_class::API_URL).to eq 'https://tuxexchange.com/api' }
end
