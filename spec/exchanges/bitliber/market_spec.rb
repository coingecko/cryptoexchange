require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitliber::Market do
  it { expect(described_class::NAME).to eq 'bitliber' }
  it { expect(described_class::API_URL).to eq 'https://bitliber.com/api/v1' }
end
