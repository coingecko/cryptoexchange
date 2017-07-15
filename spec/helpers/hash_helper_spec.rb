require 'spec_helper'
require_relative '../../lib/cryptoexchange/helpers/hash_helper'

RSpec.describe HashHelper do
  describe :dig do
    it "should return the requested value based on the selector" do
      hash = {a: {b: 1}, b: 2, c: 3}
      expect(HashHelper.dig(hash, :a, :b)).to eq 1
    end

    it "should return the first arg when selector is not given" do
      hash = {a: 1, b: 2}
      expect(HashHelper.dig(hash)).to eq hash
    end

    it "should return nil and not throw when the selector ask for a non-existent key" do
      hash = {a: {b: 1}, c: 2}
      expect(HashHelper.dig(hash, :b)).to be_nil
      expect(HashHelper.dig(hash, :a, :c)).to be_nil
    end
  end
end
