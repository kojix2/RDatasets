RSpec.describe Daru::DataFrame do
  it 'can create dataframe from rdataset' do
    expect(Daru::DataFrame.from_rdataset('datasets', 'iris').class).to eq Daru::DataFrame
  end

  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '/*')).each do |dirpath|
    package = File.basename(dirpath)
    Dir.glob(File.join(dirpath, '/*')).each do |filepath|
      dataset = File.basename(filepath, '.csv')
      it "can load the #{dataset} dataset" do
        expect(Daru::DataFrame.from_rdataset(package, dataset).class).to eq Daru::DataFrame
      end
    end
  end
end
