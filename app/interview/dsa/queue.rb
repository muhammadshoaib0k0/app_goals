class Queue
    attr_reader :items
  
    def initialize
      @items = []
    end
  
    def enqueue(item)
      @items.unshift(item)
    end
  
    def dequeue
      @items.pop
    end
  
    def size
      @items.length
    end
  end

#   https://medium.com/@paulndemo/stack-queue-and-deque-data-structures-in-ruby-64ce9a546247
