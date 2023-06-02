require "ranking_distance"

RSpec.describe RankingDistance do
  it 'has a version number' do
    expect(RankingDistance::VERSION).not_to be nil
  end

  #
  # Absolute distance
  #
  it "computes absolue distance between two empty array as 0" do
    expect(RankingDistance.absolute_distance([], [])).to eq(0)
  end

  it "computes absolue distance between two equal arrays as 0" do
    arr = [:elem1, :elem2, :elem3]
    expect(RankingDistance.absolute_distance(arr, arr)).to eq(0)
  end

  it "computes absolue distance between two arrays with one element difference at the end as 1" do
    arr1 = [:elem1, :elem2, :elem3]
    arr2 = arr1.dup << :elem4
    expect(RankingDistance.absolute_distance(arr1, arr2)).to eq(1)
  end

  it "computes absolue distance between two arrays of with one element difference at the start as the length of the longtest array" do
    arr1 = [:elem1, :elem2, :elem3]
    arr2 = [:elem0].concat(arr1)
    expect(RankingDistance.absolute_distance(arr1, arr2)).to eq(arr2.length)
  end

  #
  # Relative distance
  #
  it "computes absolue distance between two empty array as 0" do
    expect(RankingDistance.relative_distance([], [])).to eq(0)
  end

  it "computes relative distance between two completely different arrays as 1" do
    arr1 = [:elem1, :elem2, :elem3]
    arr2 = [:elem4, :elem5, :elem6]
    expect(RankingDistance.relative_distance(arr1, arr2)).to eq(1)
  end

  it "considers higher relative distance if new element at the front of the array rather than at the back" do
    arr1 = [:elem1, :elem2, :elem3] # base array
    arr2 = [:elem0].concat(arr1) # new element at the front
    arr3 = arr1.dup << :elem4 # new element at the back

    d12 = RankingDistance.relative_distance(arr1, arr2)
    d13 = RankingDistance.relative_distance(arr1, arr3)

    expect(d12).to be > d13
  end
end