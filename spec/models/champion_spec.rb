require 'rails_helper'

RSpec.describe Champion, type: :model do
  let(:champion) { FactoryBot.build_stubbed(:champion) }
  let(:invalid_tier) { FactoryBot.build_stubbed(:champion, :invalid_tier) }
  let(:invalid_name) { FactoryBot.build_stubbed(:champion, :invalid_name) }
  let(:jax) { FactoryBot.build_stubbed(:champion, :jax) }
  let(:katarina) { FactoryBot.build_stubbed(:champion, :katarina) }
  let(:lucian) { FactoryBot.build_stubbed(:champion, :lucian) }
  let(:zed) { FactoryBot.build_stubbed(:champion, :zed) }

  it "has a name attribute" do
    expect(champion).to respond_to(:name)
  end

  it "has a tier attribute" do
    expect(champion).to respond_to(:tier)
  end

  it "can calculate champion score based on tier" do
    expect(jax).to have_score(3)
    expect(zed).to have_score(4)
  end

  it "does not calculate a score with a poor tier input" do
    expect(invalid_tier).to have_score(nil)
  end

  it "does not calculate a score with a poor name input" do
    expect(invalid_name).to have_score(nil)
  end

  it "can calculate champion score based on all tiers C, B, A, and S (scores 1-4 respectively)" do
    expect(katarina).to have_score(1)
    expect(lucian).to have_score(2)
    expect(jax).to have_score(3)
    expect(zed).to have_score(4)
  end

  describe "fakes/mocks" do
    let(:big_dependency) { BigDependency.new }
    let(:stub_champ) { Champion.new }
    let(:mock_champ) { Champion.new }

    it "returns the correct value from its perform method" do
      allow(stub_champ).to receive(:perform).and_return(42)
      expect(stub_champ.perform(big_dependency)).to eq(42)
    end

    it "returns the correct value from its perform method 2" do
      expect(mock_champ).to receive(:perform).and_return(42)
      expect(mock_champ.perform(big_dependency)).to eq(42)
    end

    it "returns the correct value from its perform method 3" do
      instance_twin = instance_double(Champion)
      expect(instance_twin).to receive(:perform).and_return(42)
      expect(instance_twin.perform(big_dependency)).to eq(42)
    end
  end
end
