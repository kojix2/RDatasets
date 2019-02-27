require 'rdatasets/version'
require 'daru'

# Module for RDatasets
module RDatasets
  class Package
    def initialize(package_name)
      @package_name = package_name
    end

    def inspect
      RDatasets.packages @package_name
    end

    private

    def method_missing(name)
      RDatasets.load @package_name, name
    end
  end

  private

  def self.method_missing(package_name)
    return Package.new(package_name) if RDatasets.packages.include? package_name

    super
  end

  module_function

  # Load a certain dataset and returns a dataframe.
  # @param package_name [String, Symbol] :R package name
  # @param dataset_name [String, Symbol] :R dataset name
  # @return [Daru::DataFrame]
  def load(package_name, dataset_name = nil)
    if dataset_name
      file_path = filepath(package_name, dataset_name)
      df = Daru::DataFrame.from_csv(file_path)
      if original_index_is_sequential? df
        # `df.set_index` is slow
        df.index = df[0]
        df.delete_vector df[0].name
      end
      df
    else
      packages(package_name)
    end
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
    dataset_name += '.csv'
    File.join(rdata_directory, package_name, dataset_name)
  end

  # Display information of all data sets.
  # @return [Daru::DataFrame]
  def datasets
    file_path = File.expand_path('../data/datasets.csv', __dir__)
    Daru::DataFrame.from_csv(file_path)
  end

  #
  # @overload packages
  #   Show a list of all packages.
  #   @return [Array<Symbol>]
  # @overload packages(package_name)
  #   Show a list of datasets included in the package.
  #   @param [String, Symbol] :R package name
  #   @return [Array<Symbol>]
  def packages(package_name = nil)
    if package_name
      df = datasets
      ds = df.where(df['Package'].eq package_name.to_s)
      ds['Item'].to_a.map(&:to_sym)
    else
      datasets['Package'].to_a.uniq.map(&:to_sym)
    end
  end

  # Search available datasets. (items and titles)
  # If the argument is a string, ignore case.
  # @param pattern [String, Regexp] :The pattern to search for
  # @return [Daru::DataFrame]
  def search(pattern)
    pattern = /#{pattern}/i if pattern.is_a? String
    p pattern
    datasets.filter(:row) do |row|
      row['Item'] =~ pattern || row['Title'] =~ pattern
    end
  end

  # Check if the index of original r dataset is sequential.
  def original_index_is_sequential?(dataframe)
    dataframe[0].to_a == [*1..dataframe.size]
  end
  private_class_method :original_index_is_sequential?
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
