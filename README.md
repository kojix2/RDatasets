# RDatasets
[![Gem Version](https://badge.fury.io/rb/rdatasets.svg)](https://badge.fury.io/rb/rdatasets)
[![Build Status](https://travis-ci.org/kojix2/rdatasets.svg?branch=master)](https://travis-ci.org/kojix2/rdatasets)

RDatasets for Ruby.
* [RDatasets](https://github.com/vincentarelbundock/Rdatasets)
* [RDatasets.jl](https://github.com/johnmyleswhite/RDatasets.jl)

## Installation

```bash
git clone https://github.com/kojix2/rdatasets
cd rdatasets
bundle install
bundle exec rake install
```

## Usage

```ruby
require 'rdatasets'
df = Daru::DataFrame.from_rdatasets("datasetss","iris")
df = RDatasets.load("datasets", "iris")
```

## Development
What I do NOT do
* Add data other than the CSV file. 
* Add custom useful methods for each data set.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/kojix2/rdatasets.

## License
See the documents below.
* https://github.com/vincentarelbundock/Rdatasets#license
* https://github.com/johnmyleswhite/RDatasets.jl#licensing-and-intellectual-property
