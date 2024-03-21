# frozen_string_literal: true

class Node
  attr_accessor :data, :next

  def initialize(data, next_node = nil)
    @data = data
    @next = next_node
  end
end

a = Node.new(5)
puts a
