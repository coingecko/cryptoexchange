require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitconnect::Market do
  it { expect(described_class::API_URL).to eq 'https://bitconnect.co/api' }
end
