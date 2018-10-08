require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Blackturtle::Market do
  it { expect(described_class::NAME).to eq 'blackturtle' }
  it { expect(described_class::API_URL).to eq 'https://bot.blackturtle.eu/api' }
end
