# frozen_string_literal: true

require 'rdatasets/version'
require 'daru'

# Module for RDatasets
module RDatasets
  class Package
    def initialize(package_name)
      @package_name = package_name
      @datasets = RDatasets.package package_name
    end

    private

    def method_missing(name)
      return RDatasets.load @package_name, name if @datasets.include? name

      super
    end
  end

  private_constant :Package

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
      file_path = get_file_path(package_name, dataset_name)
      raise "No such file -- #{file_path}" unless File.exist? file_path

      dataframe = Daru::DataFrame.from_csv(file_path)
      if original_index_is_sequential? dataframe
        # `dataframe.set_index` is slow
        dataframe.index = dataframe.at 0
        dataframe.delete_vector dataframe.at(0).name
      end
      dataframe
    else
      package(package_name)
    end
  end

  # Get the file path of a certain dataset.
  # @param package_name [String, Symbol] :R package name
  # @param dataset_name [String, Symbol] :R dataset name
  # @return [String]
  def get_file_path(package_name, dataset_name)
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
  def df
    file_path = File.expand_path('../data/datasets.csv', __dir__)
    Daru::DataFrame.from_csv(file_path)
  end

  # Show a list of all packages.
  # @return [Array<Symbol>]
  def packages
    df['Package'].to_a.uniq.map(&:to_sym)
  end

  # Show a list of datasets included in the package.
  # @param [String, Symbol] :R package name
  # @return [Array<Symbol>]
  def package(package_name)
    ds = df.where(df['Package'].eq package_name.to_s)
    ds['Item'].to_a.map(&:to_sym)
  end

  # Search available datasets. (items and titles)
  # If the argument is a string, ignore case.
  # @param pattern [String, Regexp] :The pattern to search for
  # @return [Daru::DataFrame]
  def search(pattern)
    pattern = /#{pattern}/i if pattern.is_a? String
    df.filter(:row) do |row|
      row['Item'] =~ pattern || row['Title'] =~ pattern
    end
  end

  # Check if the index of original r dataset is sequential.
  def original_index_is_sequential?(dataframe)
    dataframe.at(0).to_a == [*1..dataframe.size]
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
