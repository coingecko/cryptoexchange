require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Digitalprice::Market do
  it { expect(described_class::NAME).to eq 'digitalprice' }
  it { expect(described_class::API_URL).to eq 'https://altsbit.com/api' }
end
