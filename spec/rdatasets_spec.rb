# frozen_string_literal: true

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
    df = RDatasets.search(/ing$/)
    # 41 was confirmed by MS Excel.
    expect(df.size).to eq 41
  end

  it 'can load datasets with method chain' do
    df1 = RDatasets.load :datasets, :iris
    df2 = RDatasets.datasets.iris
    expect(df1 == df2).to eq true
  end

  it 'dose not respond to the wrong package name' do
    expect(RDatasets.respond_to?(:wrong_package_name)).to be false
    expect { RDatasets.respond_to?(3) }.to raise_error(TypeError)
  end

  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '*/')).sort.each do |dirpath|
    package = File.basename(dirpath)

    it "respond to the package name #{package}" do
      expect(RDatasets.respond_to?(package)).to be true
    end

    package_object = RDatasets.public_send(package)

    it 'dose not respond to the wrong dataset name' do
      expect(package_object.respond_to?(:wrong_dataset_name)).to be false
      expect { package_object.respond_to?(3) }.to raise_error(TypeError)
    end

    Dir.glob(File.join(dirpath, '*')).sort.each do |filepath|
      dataset = File.basename(filepath, '.csv')

      it "respond to the dataset name #{dataset} in #{package}" do
        expect(package_object.respond_to?(dataset)).to be true
      end

      it "can load the #{package}/#{dataset} dataset with String" do
        expect(RDatasets.load(package, dataset)).to be_an_instance_of Daru::DataFrame
      end

      it "can load the #{package}/#{dataset} dataset with Symbol" do
        expect(RDatasets.load(package.to_sym, dataset.to_sym)).to be_an_instance_of Daru::DataFrame
      end

      it "can load the #{package}/#{dataset} dataset with method chain" do
        # WHY `public_send` ?
        # `send` can call private methods.
        # This cause trouble especially when calling `sleep`.
        expect(RDatasets.public_send(package.to_sym)
                        .public_send(dataset.to_sym)).to be_an_instance_of Daru::DataFrame
      end
    end
  end
end
