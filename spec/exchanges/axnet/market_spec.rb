require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Axnet::Market do
  it { expect(described_class::NAME).to eq 'axnet' }
  it { expect(described_class::API_URL).to eq 'https://ax.net/api' }
end
