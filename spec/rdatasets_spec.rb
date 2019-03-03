RSpec.describe RDatasets do
  it 'has a version number' do
    expect(RDatasets::VERSION).not_to be nil
  end

  it 'show a list of packages' do
    expect(RDatasets.df.class).to eq Daru::DataFrame
  end

  it 'can set index' do
    df = RDatasets.load :datasets, :iris
    expect(df[0].to_a).not_to eq Array.new(df.size) { |i| i + 1 }
  end

  it 'can search "diamond"' do
    df = RDatasets.search 'diamond'
    expect(df.size).to eq 4
  end

  it 'can search /ing$/' do
    df = RDatasets.search /ing$/
    expect(df.size).to eq 33
  end

  it 'can load datasets vi method chain' do
    df1 = RDatasets.load :datasets, :iris
    df2 = RDatasets.datasets.iris
    expect(df1 == df2).to eq true
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
