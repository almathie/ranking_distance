# RankingDistance

RankingDistance is a Ruby gem that provides a simple and efficient way to compute the distance between two rankings. Rankings are arrays of elements, and the distance is a positive number that is small when the rankings are similar and bigger when they are not.

Unlike other edit distances, such as the Levenshtein distance, RankDistance weights more the insertions at the front of the rankings and gives less weight to insertions at the back of the rankings. This makes the distance computed by RankDistance more reflective of the percived similarity between the rankings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ranking_distance'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ranking_distance

## Usage

3 Methods are available:

`RankingDistance.absolute_distance(arr1, arr2)`

    Computes the absolute distance between two arrays.
    The absolute distance is computed as follows:
    - if the two arrays are equal, the distance is 0
    - if the two arrays are different, the distance is the number of swaps and insertions needed to transform one array into the other
    - Each swap cost is dependent on the distance between the two swapped elements
    - Each insertion cost is dependent on the position of the inserted element (inserting at the end is cheaper than inserting at the start)
    The absolute distance is thus always a positive integer.

`RankingDistance.relative_distance(arr1, arr2)`

    Computes the relative distance between two arrays.
    The relative distance is computed by dividing the absolute distance by the maximum possible distance between the two arrays.
    This means that the relative distance is always a float between 0 and 1.
    0 if the two arrays are equal, 1 if the two arrays are built with completely different elements.

`RankingDistance.relative_proximity(arr1, arr2)`

    Computes the relative proximity between two arrays.
    The relative proximity is computed by substracting the relative distance from 1.
    This means that the relative proximity is always a float between 0 and 1.
    1 if the two arrays are equal, 0 if the two arrays are built with completely different elements.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/almathie/ranking_distance.
