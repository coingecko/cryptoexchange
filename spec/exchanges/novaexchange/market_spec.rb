require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Novaexchange::Market do
  it { expect(described_class::NAME).to eq 'novaexchange' }
  it { expect(described_class::API_URL).to eq 'https://novaexchange.com/remote/v2' }
end
