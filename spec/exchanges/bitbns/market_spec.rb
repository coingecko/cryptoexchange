require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbns::Market do
  it { expect(described_class::NAME).to eq 'bitbns' }
  it { expect(described_class::API_URL).to eq 'https://bitbns.com' }
end
