require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Phemex::Market do
  it { expect(described_class::NAME).to eq 'phemex' }
  it { expect(described_class::API_URL).to eq 'https://api.phemex.com/v1/md' }
end
