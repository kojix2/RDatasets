RSpec.describe RDataset do
  it 'has a version number' do
    expect(RDataset::VERSION).not_to be nil
  end

  it 'can load the iris dataset' do
    expect(RDataset.load('datasets', 'iris').class).to eq Daru::DataFrame
  end
end
