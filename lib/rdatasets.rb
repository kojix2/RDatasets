# frozen_string_literal: true

require 'rdatasets/version'

require "red_amber"

# Module for RDatasets
module RDatasets
  # R packages.
  class Package
    attr_reader :package_name

    def initialize(package_name)
      @package_name = package_name
      @datasets = RDatasets.package package_name
    end

    private

    def method_missing(name)
      return RDatasets.load @package_name, name if @datasets.include? name

      super
    end

    def respond_to_missing?(name, include_private)
      @datasets.include?(name) ? true : super
    end
  end

  private_constant :Package

  def self.method_missing(package_name)
    return Package.new(package_name) if RDatasets.packages.include? package_name

    super
  end

  def self.respond_to_missing?(package_name, include_private)
    RDatasets.packages.include?(package_name) ? true : super
  end

  module_function

  # Load a certain dataset and returns a dataframe.
  # @param package_name [String, Symbol] :R package name
  # @param dataset_name [String, Symbol] :R dataset name
  # @return [RedAmber::DataFrame]
  def load(package_name, dataset_name = nil)
    if dataset_name
      file_path = get_file_path(package_name, dataset_name)
      raise "No such file -- #{file_path}" unless File.exist? file_path

      dataframe = RedAmber::DataFrame.load(file_path)
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
    dataset_name += '.csv.gz'
    File.join(rdata_directory, package_name, dataset_name)
  end

  # Display information of all data sets.
  # @return [RedAmber::DataFrame]
  def df
    file_path = File.expand_path('../data/datasets.csv.gz', __dir__)
    RedAmber::DataFrame.load(file_path)
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
  # @return [RedAmber::DataFrame]
  def search(pattern)
    pattern = /#{pattern}/i if pattern.is_a? String
    df.filter(:row) do |row|
      row['Item'] =~ pattern || row['Title'] =~ pattern
    end
  end
end

module RedAmber
  class DataFrame
    # Read a certain dataset from the Rdatasets and returns a dataframe.
    # @param package_name [String, Symbol] :R package name
    # @param dataset_name [String, Symbol] :R dataset name
    # @return [RedAmber::DataFrame]
    def self.from_rdatasets(package_name, dataset_name)
      RDatasets.load(package_name, dataset_name)
    end
  end
end
