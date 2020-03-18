require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coindcx::Market do
  it { expect(described_class::NAME).to eq 'coindcx' }
  it { expect(described_class::API_URL).to eq 'https://api.coindcx.com' }
  it { expect(described_class::API_URL_2).to eq 'https://public.coindcx.com' }
end
