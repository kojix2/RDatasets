require "rdataset/version"
require "daru"

module RDataset
  def self.load(package_name, dataset_name)
    rdata_directory = File.expand_path('../../data', __FILE__)
    dataset_name << ".csv"
    filepath = File.join(rdata_directory, package_name, dataset_name)
    df = Daru::DataFrame.from_csv(filepath)
  end
end

module Daru
  class DataFrame
    def self.from_rdataset(package_name, dataset_name)
      RDataset.load(package_name, dataset_name)
    end
  end
end
