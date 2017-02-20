# frozen_string_literal: true

require 'parallel'
require 'key_value_name'

module Twenty48
  LayerPartName = KeyValueName.new do |n|
    n.key :sum, type: Numeric, format: '%04d'
    n.key :max_value, type: Numeric, format: '%x'
    n.extension :vbyte
  end

  #
  # Layer Part: A 'layer' has the same sum, and a 'layer part' has the same
  # sum and `max_value`.
  #
  class LayerPartName
    def read_states(board_size, folder:)
      Twenty48.read_states_vbyte(board_size, self.in(folder))
    end
  end

  LayerPartInfoName = KeyValueName.new do |n|
    n.include_keys LayerPartName
    n.extension :json
  end

  LayerPartValuesName = KeyValueName.new do |n|
    n.include_keys LayerPartName
    n.extension :values
  end

  LayerPartPolicyName = KeyValueName.new do |n|
    n.include_keys LayerPartName
    n.extension :policy
  end

  LayerFragmentName = KeyValueName.new do |n|
    n.key :input_sum, type: Numeric, format: '%04d'
    n.key :input_max_value, type: Numeric, format: '%x'
    n.key :output_sum, type: Numeric, format: '%04d'
    n.key :output_max_value, type: Numeric, format: '%x'
    n.key :remainder, type: Numeric, format: '%02d'
    n.key :fragment, type: Numeric, format: '%04d'
    n.extension :vbyte
  end

  #
  # A fragment of a layer that is still being built.
  #
  class LayerFragmentName
    def read_states(board_size, folder:)
      Twenty48.read_states_vbyte(board_size, self.in(folder))
    end
  end

  #
  # Handling for layer files.
  #
  module Layers
    def layer_part_pathname(sum, max_value, folder: layer_folder)
      LayerPartName.new(sum: sum, max_value: max_value).in(folder)
    end

    def layer_part_info_pathname(sum, max_value, folder: layer_folder)
      LayerPartInfoName.new(sum: sum, max_value: max_value).in(folder)
    end

    def find_max_values(layer_sum, folder: layer_folder)
      LayerPartName.glob(folder)
        .map { |name| name.max_value if name.sum == layer_sum }
        .compact
        .sort
    end
  end
end