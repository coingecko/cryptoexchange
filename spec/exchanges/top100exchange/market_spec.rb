require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Top100exchange::Market do
  it { expect(described_class::NAME).to eq 'top100exchange' }
  it { expect(described_class::API_URL).to eq 'https://member.top100exchange.co.uk/API.svc' }
end
