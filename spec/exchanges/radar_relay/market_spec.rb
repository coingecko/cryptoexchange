require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::RadarRelay::Market do
  it { expect(described_class::NAME).to eq 'radar_relay' }
  it { expect(described_class::API_URL).to eq 'https://api.radarrelay.com/v2' }
end
