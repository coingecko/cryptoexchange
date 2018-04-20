require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Graviex::Market do
  it { expect(described_class::NAME).to eq 'graviex' }
  it { expect(described_class::API_URL).to eq 'https://graviex.net/api/v2' }
end

