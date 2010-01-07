module Tomafro
  module Jekyll
    module Tags 
      # {% post "2009/08/this-is-the-url" %}
         
      class RelatedTag < Liquid::Tag
        def initialize(tag_name, url, tokens)
          super
          @url = url.strip
          @file = 'related-posts.markdown'
        end

        def render(context)
          context.stack do
            site = context.registers[:site]
            post = site.posts.detect {|x| x.url == context['page']['url'] }
            related = post.categories.inject([]) do |memo, tag|
              memo << site.posts.select {|p| p.categories.include?(tag) }
            end
            related = (related.flatten.uniq - [post])
            
            # top up related if less than 5 entries
            
            if related.size < 7
              missing = 7 - related.size
              candidates = (site.posts - related - [post])
              related = related + candidates[0..missing]
            end
            
            context.scopes.last['related'] = related

            Dir.chdir(File.join(context.registers[:site].source, '_includes')) do
              choices = Dir['**/*'].reject { |x| File.symlink?(x) }
              if choices.include?(@file)
                source = File.read(@file)
                partial = Liquid::Template.parse(source)
                context.stack do
                  partial.render(context)
                end
              else
                "Included file '#{@file}' not found in _includes directory"
              end
            end
          end
        end
      end
    end
  end
end

Liquid::Template.register_tag('related', Tomafro::Jekyll::Tags::RelatedTag)
