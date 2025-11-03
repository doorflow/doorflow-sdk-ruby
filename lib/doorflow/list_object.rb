module DoorFlow
  class ListObject
    include Enumerable

    attr_reader :data, :total, :page, :per_page

    def initialize(data:, total: nil, page: nil, per_page: nil, resource_class:)
      @data = data
      @total = total
      @page = page
      @per_page = per_page
      @resource_class = resource_class
    end

    def each(&block)
      @data.each(&block)
    end

    def [](index)
      @data[index]
    end

    def size
      @data.size
    end

    def empty?
      @data.empty?
    end

    def first
      @data.first
    end

    def last
      @data.last
    end

    # Auto-pagination - fetch all pages automatically
    def auto_paging_each(&block)
      current_page = @page || 1
      current_data = @data

      loop do
        current_data.each(&block)

        # Check if there are more pages
        break unless has_more?(current_page)

        current_page += 1
        current_data = fetch_next_page(current_page)
        break if current_data.nil? || current_data.empty?
      end
    end

    private

    def has_more?(current_page)
      return false unless @total && @per_page
      (current_page * @per_page) < @total
    end

    def fetch_next_page(page)
      # This will be overridden by specific list implementations
      []
    end
  end
end
