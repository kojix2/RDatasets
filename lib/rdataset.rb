require 'rdataset/version'
require 'daru'

module RDataset
  class << self
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
end

module Daru
  class DataFrame
    def self.from_rdataset(package_name, dataset_name)
      RDataset.load(package_name, dataset_name)
    end
  end
end
