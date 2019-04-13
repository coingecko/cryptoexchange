require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitex::Market do
  it { expect(described_class::NAME).to eq 'bitex' }
  it { expect(described_class::API_URL).to eq 'https://bitex.la/api-v1/rest' }
end
