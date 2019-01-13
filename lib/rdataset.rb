require "rdataset/version"
require "daru"

module Daru
  class RDataset
    def initialize(package_name, dataset_name)
      rdata_directory = File.expand_path('../../data', __FILE__)
      dataset_name << ".csv"
      filepath = File.join(rdata_directory, package_name, dataset_name)
      df = Daru::DataFrame.from_csv(filepath)
    end
  end
end
