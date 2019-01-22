RSpec.describe RDatasets do
  it 'has a version number' do
    expect(RDatasets::VERSION).not_to be nil
  end

  it 'show a list of packages' do
    expect(RDatasets.datasets.class).to eq Daru::DataFrame
  end

  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '/*')).sort.each do |dirpath|
    package = File.basename(dirpath)

    Dir.glob(File.join(dirpath, '/*')).sort.each do |filepath|
      dataset = File.basename(filepath, '.csv')

      next if dataset == 'friendship'
      next if dataset == 'sna.ex'

      it "can load the #{package}/#{dataset} dataset with String" do
        expect(RDatasets.load(package, dataset).class).to eq Daru::DataFrame
      end

      it "can load the #{package}/#{dataset} dataset with Symbol" do
        expect(RDatasets.load(package.to_sym, dataset.to_sym).class).to eq Daru::DataFrame
      end
    end
  end
end
