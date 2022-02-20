module LocalTimeHelper
  def local_date(time, options = nil)
    options, format = extract_options_and_value(options, :format)
    options[:format] = format || LocalTime.default_date_format
    local_time time, options
  end
end