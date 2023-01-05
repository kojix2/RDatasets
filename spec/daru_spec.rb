# frozen_string_literal: true

RSpec.describe RedAmber::DataFrame do
  rdata_directory = File.expand_path('../data', __dir__)
  Dir.glob(File.join(rdata_directory, '*/')).sort.each do |dirpath|
    package = File.basename(dirpath)

    Dir.glob(File.join(dirpath, '*')).sort.each do |filepath|
      dataset = File.basename(filepath, '.csv.gz')

      it "can load the #{package}/#{dataset} dataset with String" do
        expect(RedAmber::DataFrame.from_rdatasets(package, dataset).class).to eq RedAmber::DataFrame
      end

      it "can load the #{package}/#{dataset} dataset with Symbol" do
        expect(RedAmber::DataFrame.from_rdatasets(package.to_sym, dataset.to_sym).class).to eq RedAmber::DataFrame
      end
    end
  end
end
