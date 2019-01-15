# RDataset

RDatasets for Ruby.
* [RDatasets](https://github.com/vincentarelbundock/Rdatasets)
* [RDatasets.jl](https://github.com/johnmyleswhite/RDatasets.jl)

## Installation

```bash
git clone https://github.com/kojix2/rdataset
cd rdataset
bundle install
bundle exec rake install
```

## Usage

```ruby
require 'rdataset'
df = Daru::DataFrame.from_rdataset("datasets","iris")
df = RDataset.load("datasets", "iris")
```

## Development
What I do NOT do
* Add data other than the CSV file. 
* Add custom useful methods for each data set.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/kojix2/rdataset.

## License
Follow the document below.
* https://github.com/vincentarelbundock/Rdatasets#license
* https://github.com/johnmyleswhite/RDatasets.jl#licensing-and-intellectual-property
