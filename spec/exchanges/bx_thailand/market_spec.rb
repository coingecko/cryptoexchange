require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BxThailand::Market do
  it { expect(described_class::NAME).to eq 'bx_thailand' }
  it { expect(described_class::API_URL).to eq 'https://bx.in.th/api/' }
end
