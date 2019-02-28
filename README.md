# RDatasets
[![Gem Version](https://badge.fury.io/rb/rdatasets.svg)](https://badge.fury.io/rb/rdatasets)
[![Build Status](https://travis-ci.org/kojix2/rdatasets.svg?branch=master)](https://travis-ci.org/kojix2/rdatasets)

RDatasets for Ruby.
This ruby gem allows you to access over 1200 datasets included in R from Ruby. 

- All the datasets were ported from [RDatasets](https://github.com/vincentarelbundock/Rdatasets) created by Vincent.
- This Ruby gem was inspired by [RDatasets.jl](https://github.com/johnmyleswhite/RDatasets.jl) created by John Myles White.

under development

## Installation

```bash
gem install rdatasets
```

## Usage

```ruby
require 'rdatasets'
df = Daru::DataFrame.from_rdatasets("datasets","iris")
df = RDatasets.load "datasets", "iris"
df = RDatasets.load :datasets, :iris
df = RDatasets.datasets.iris
# returns Daru::DataFrame

# available datasets
df = RDatasets.df

# search
RDatasets.search "diamonds"
RDatasets.search /diamonds/
```

## Development
What I do NOT do
- Add data other than the CSV file. 
- Add custom useful methods for each data set.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/kojix2/rdatasets.

## License
GPL-3. See the documents below.
- https://github.com/vincentarelbundock/Rdatasets#license
- https://github.com/johnmyleswhite/RDatasets.jl#licensing-and-intellectual-property
