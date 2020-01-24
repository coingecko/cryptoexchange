require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitubu::Market do
  it { expect(described_class::NAME).to eq 'bitubu' }
  it { expect(described_class::API_URL).to eq 'https://bitubu.com/api/v2' }
end
