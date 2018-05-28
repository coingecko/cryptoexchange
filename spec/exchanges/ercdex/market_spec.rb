require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ercdex::Market do
  it { expect(described_class::NAME).to eq 'ercdex' }
  it { expect(described_class::API_URL).to eq 'https://api.ercdex.com/api' }
end
