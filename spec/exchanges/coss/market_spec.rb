require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coss::Market do
  it { expect(described_class::API_URL).to eq 'https://exchange.coss.io/api' }
end
