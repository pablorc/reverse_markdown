require 'digest'
require 'reverse_markdown/version'
require 'reverse_markdown/mapper'
require 'reverse_markdown/errors'
require 'nokogiri'

module ReverseMarkdown

  def self.parse(input, opts={})
    root = case input
      when String                  then Nokogiri::HTML(input).root
      when Nokogiri::XML::Document then input.root
      when Nokogiri::XML::Node     then input
    end

    ReverseMarkdown::Mapper.new(opts).process_root(root)
  end

  def self.pre_parse input, opts={}
    input.gsub!("<pre>", "<pre><code>")
    input.gsub!("</pre>", "</code></pre>")
    self.parse input, opts
  end


  # 2012/08/11 joe: possibly deprecate in favour of #parse
  class << self
    alias parse_string  parse
    alias parse_element parse
  end
end
