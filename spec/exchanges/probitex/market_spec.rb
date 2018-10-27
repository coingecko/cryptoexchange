require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Probitex::Market do
  it { expect(described_class::NAME).to eq 'probitex' }
  it { expect(described_class::API_URL).to eq 'https://www.probitex.com/apis' }
end
