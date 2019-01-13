require "rdataset/version"
require "daru"

module RDataset
  class << self
    def dataset(package_name, dataset_name)
      rdata_directory = File.expand_path('../../data', __FILE__)
      filepath = File.join(rdata_directory, package_name, dataset_name)
      df = Daru::DataFrame.from_csv(filepath)
    end
  end
end
