RSpec.describe RDataset do
  it 'has a version number' do
    expect(RDataset::VERSION).not_to be nil
  end

  it 'can load the iris dataset' do
    expect(RDataset.load('datasets', 'iris').class).to eq Daru::DataFrame
  end

  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '/*')).each do |dirpath|
    package = File.basename(dirpath)

    Dir.glob(File.join(dirpath, '/*')).each do |filepath|
      dataset = File.basename(filepath, '.csv')

      next if dataset == 'friendship'
      next if dataset == 'sna.ex'

      it "can load the #{package}/#{dataset} dataset" do
        expect(RDataset.load(package, dataset).class).to eq Daru::DataFrame
      end
    end
  end
end
