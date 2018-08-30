require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paroexchange::Market do
  it { expect(described_class::NAME).to eq 'paroexchange' }
  it { expect(described_class::API_URL).to eq 'https://paroexchange-front-api-php.azurewebsites.net' }
end
