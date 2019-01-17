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
    package_name = package_name.to_s if package_name.is_a? Symbol
    dataset_name = dataset_name.to_s if dataset_name.is_a? Symbol

    # "car" package directory is a symbolic link.
    # Do not use Symbolic links because they can cause error on Windows.
    package_name = 'carData' if package_name == 'car'
    dataset_name << '.csv'
    File.join(rdata_directory, package_name, dataset_name)
  end

  def packages
    file_path = File.expand_path('../data/datasets.csv', __dir__)
    Daru::DataFrame.from_csv(file_path)
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
