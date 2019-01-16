require 'rdatasets/version'
require 'daru'

# Module for RDatasets
module RDatasets
  module_function

  # Load a certain dataset and returns a dataframe.
  # @param package_name [String, Symbol] :R package name
  # @param dataset_name [String, Symbol] :R dataset name
  # @return [Daru::DataFrame]
  def load(package_name, dataset_name)
    file_path = filepath(package_name, dataset_name)
    Daru::DataFrame.from_csv(file_path)
  end

  # Get the file path of a certain dataset.
  # @param package_name [String, Symbol] :R package name
  # @param dataset_name [String, Symbol] :R dataset name
  # @return [String]
  def filepath(package_name, dataset_name)
    rdata_directory = File.expand_path('../data', __dir__)
    dataset_name << '.csv'
    File.join(rdata_directory, package_name, dataset_name)
  end
end

module Daru
  class DataFrame
    # Read a certain dataset from the Rdatasets and returns a dataframe.
    # @param package_name [String, Symbol] :R package name
    # @param dataset_name [String, Symbol] :R dataset name
    # @return [Daru::DataFrame]
    def self.from_rdatasets(package_name, dataset_name)
      RDatasets.load(package_name, dataset_name)
    end
  end
end
