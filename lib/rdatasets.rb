require 'rdatasets/version'
require 'daru'

module RDatasets
  module_function

  def load(package_name, dataset_name)
    file_path = filepath(package_name, dataset_name)
    Daru::DataFrame.from_csv(file_path)
  end

  def filepath(package_name, dataset_name)
    rdata_directory = File.expand_path('../data', __dir__)
    dataset_name << '.csv'
    File.join(rdata_directory, package_name, dataset_name)
  end
end

module Daru
  class DataFrame
    def self.from_rdatasets(package_name, dataset_name)
      RDatasets.load(package_name, dataset_name)
    end
  end
end
