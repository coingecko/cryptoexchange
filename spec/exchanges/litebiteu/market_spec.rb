require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Litebiteu::Market do
  it { expect(described_class::NAME).to eq 'litebiteu' }
  it { expect(described_class::API_URL).to eq 'https://api.litebit.eu' }
end
