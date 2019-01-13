RSpec.describe Daru::DataFrame do
  it "can create dataframe from rdataset" do
    expect(Daru::DataFrame.from_rdataset("datasets","iris").class).to eq Daru::DataFrame
  end
end

