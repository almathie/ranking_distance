# frozen_string_literal: true

require_relative "ranking_distance/version"

module RankingDistance
  class Error < StandardError; end

  # A class used to represent a unique element in an array.
  # This class is used to fill arrays with a unique element so that the arrays can be compared.
  # This class is used internally by the RankingDistance module and should not be used directly.
  class UniqueElement
    def ==(_)
      false
    end
  end

  #
  # Computes the absolute distance between two arrays.
  # The absolute distance is computed as follows:
  # - if the two arrays are equal, the distance is 0
  # - if the two arrays are different, the distance is the number of swaps and insertions needed to transform one array into the other
  # - Each swap cost is dependent on the distance between the two swapped elements
  # - Each insertion cost is dependent on the position of the inserted element (inserting at the end is cheaper than inserting at the start)
  # The absolute distance is thus always a positive integer.
  #
  # @param arr1 [Array] the first array
  # @param arr2 [Array] the second array
  # @return [Integer] the absolute distance between the two arrays
  #
  def self.absolute_distance(arr1, arr2)
    return 0 if arr1 == arr2

    shortest_arr, longest_arr = [arr1.dup, arr2.dup].sort_by(&:length)
    shortest_arr << UniqueElement.new until shortest_arr.length == longest_arr.length

    edit_distance = 0
    start_index = 0
    while start_index < longest_arr.length
      if longest_arr[start_index] != shortest_arr[start_index]
        element = longest_arr[start_index]
        element_index_in_truncated_short_array = shortest_arr.drop(start_index).index(element)
        if element_index_in_truncated_short_array # Element found -> swap
          edit_distance += element_index_in_truncated_short_array
          shortest_arr.insert(start_index, shortest_arr.delete_at(element_index_in_truncated_short_array + start_index))
        else # Element not found -> insert
          edit_distance += (longest_arr.length - start_index)
          shortest_arr.insert(start_index, element)
        end
      end
      start_index += 1
    end

    return edit_distance
  end

  #
  # Computes the relative distance between two arrays.
  # The relative distance is computed by dividing the absolute distance by the maximum possible distance between the two arrays.
  # This means that the relative distance is always a float between 0 and 1.
  # 0 if the two arrays are equal, 1 if the two arrays are built with completely different elements.
  #
  # @param arr1 [Array] the first array
  # @param arr2 [Array] the second array
  # @return [Float] the relative distance between the two arrays
  #
  def self.relative_distance(arr1, arr2)
    return 0 if arr1.empty? && arr2.empty?

    _, longest_arr = [arr1, arr2].sort_by(&:length)
    max_distance = longest_arr.length * (longest_arr.length + 1) / 2
    return absolute_distance(arr1, arr2).to_f / max_distance
  end

  #
  # Computes the relative proximity between two arrays.
  # The relative proximity is computed by substracting the relative distance from 1.
  # This means that the relative proximity is always a float between 0 and 1.
  # 1 if the two arrays are equal, 0 if the two arrays are built with completely different elements.
  #
  # @param arr1 [Array] the first array
  # @param arr2 [Array] the second array
  # @return [Float] the relative proximity between the two arrays
  #
  def self.relative_proximity(arr1, arr2)
    return 1 - relative_distance(arr1, arr2)
  end
end
