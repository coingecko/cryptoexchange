require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Idcm::Market do
  it { expect(described_class::NAME).to eq 'idcm' }
  it { expect(described_class::API_URL).to eq 'http://api.idcm.io:8303/api/v1' }
end
