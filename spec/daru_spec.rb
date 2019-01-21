RSpec.describe Daru::DataFrame do
  it 'can create dataframe from rdataset with String' do
    expect(Daru::DataFrame.from_rdatasets('datasets', 'iris').class).to eq Daru::DataFrame
  end

  it 'can create dataframe from rdataset with Symbol' do
    expect(Daru::DataFrame.from_rdatasets(:datasets, :iris).class).to eq Daru::DataFrame
  end

  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '/*')).sort.each do |dirpath|
    package = File.basename(dirpath)

    Dir.glob(File.join(dirpath, '/*')).sort.each do |filepath|
      dataset = File.basename(filepath, '.csv')

      next if dataset == 'friendship'
      next if dataset == 'sna.ex'

      it "can load the #{package}/#{dataset} dataset" do
        expect(Daru::DataFrame.from_rdatasets(package, dataset).class).to eq Daru::DataFrame
      end
    end
  end
end
