module Tomafro
  module Jekyll
    module Tags 
      # {% post "2009/08/this-is-the-url" %}
         
      class PostTag < Liquid::Tag
        def initialize(tag_name, url, tokens)
          super
          @url = url.strip
          @file = 'post-div.html'
        end

        def render(context)
          context.stack do
            post = context.registers[:site].posts.detect {|x| x.url == @url }
            context.scopes.last['page'] = post
            context.scopes.last['body'] = post.content
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

Liquid::Template.register_tag('post', Tomafro::Jekyll::Tags::PostTag)
