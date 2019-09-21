require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Mandala::Market do
  it { expect(described_class::NAME).to eq 'mandala' }
  it { expect(described_class::API_URL).to eq 'https://zapi.mandalaex.com/api' }
end
