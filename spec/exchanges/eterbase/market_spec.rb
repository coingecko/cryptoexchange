require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Eterbase::Market do
  it { expect(described_class::NAME).to eq 'eterbase' }
  it { expect(described_class::API_URL).to eq 'https://api.eterbase.exchange/api' }
end
