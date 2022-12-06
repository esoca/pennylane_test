class Page
  attr_reader :values, :total_count, :page_number, :page_size

  def initialize(values:, total_count:, page_number:, page_size:)
    @values = values
    @total_count = total_count
    @page_number = page_number
    @page_size = page_size
  end

  def total_pages
    total_count.fdiv(page_size).ceil
  end
end
