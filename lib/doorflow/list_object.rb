module DoorFlow
  # A collection of resources with pagination support
  #
  # ListObject wraps arrays of resources returned from list operations
  # and provides convenient iteration and pagination methods.
  #
  # @example Basic iteration
  #   people = DoorFlow::Person.list
  #   people.each { |person| puts person.name }
  #
  # @example Accessing pagination metadata
  #   people = DoorFlow::Person.list(page: 2, per_page: 50)
  #   puts "Page #{people.page} of #{people.total / people.per_page}"
  #
  # @example Auto-pagination (fetch all pages)
  #   people = DoorFlow::Person.list
  #   people.auto_paging_each { |person| puts person.email }
  class ListObject
    include Enumerable

    # @return [Array] the array of resource objects
    attr_reader :data

    # @return [Integer, nil] total number of items across all pages
    attr_reader :total

    # @return [Integer, nil] current page number
    attr_reader :page

    # @return [Integer, nil] number of items per page
    attr_reader :per_page

    # Create a new list object
    #
    # @param data [Array] array of resource instances
    # @param total [Integer, nil] total count across all pages
    # @param page [Integer, nil] current page number
    # @param per_page [Integer, nil] items per page
    # @param resource_class [Class] the resource class for items
    # @param client [DoorFlow::Client, nil] client instance for auto-paging
    def initialize(data:, total: nil, page: nil, per_page: nil, resource_class:, client: nil)
      @data = data
      @total = total
      @page = page
      @per_page = per_page
      @resource_class = resource_class
      @client = client
    end

    # Iterate over each item in the list
    # @yield [resource] each resource in the data array
    # @return [Enumerator] if no block given
    def each(&block)
      @data.each(&block)
    end

    # Access an item by index
    # @param index [Integer] zero-based index
    # @return [Resource, nil] resource at index, or nil
    def [](index)
      @data[index]
    end

    # Number of items in current page
    # @return [Integer] count of items
    def size
      @data.size
    end

    # Check if the list is empty
    # @return [Boolean] true if no items
    def empty?
      @data.empty?
    end

    # Get the first item
    # @return [Resource, nil] first resource or nil
    def first
      @data.first
    end

    # Get the last item
    # @return [Resource, nil] last resource or nil
    def last
      @data.last
    end

    # Automatically fetch and iterate over all pages
    #
    # This method will make additional API requests to fetch
    # subsequent pages and yield each item across all pages.
    #
    # @yield [resource] each resource across all pages
    # @example Iterate over all people across all pages
    #   people = DoorFlow::Person.list(per_page: 100)
    #   people.auto_paging_each { |person| process(person) }
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
