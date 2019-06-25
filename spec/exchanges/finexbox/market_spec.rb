require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Finexbox::Market do
  xit { expect(described_class::NAME).to eq 'finexbox' }
  xit { expect(described_class::API_URL).to eq 'https://xapi.finexbox.com/v1' }
end
