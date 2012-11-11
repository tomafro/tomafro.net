require 'pygments'
require 'rdiscount'

module Lanyon
  module Filters
    def shell(text)
      _highlight text, 'bash'
    end

    def ruby(text)
      _highlight text, 'ruby'
    end

    def zsh(text)
      _highlight text, 'bash'
    end

    def javascript(text)
      _highlight text, 'javascript'
    end

    def sql(text)
      _highlight text, 'mysql'
    end

    def markdown(text)
      RDiscount.new(render(text), :smart).to_html
    end

    def youtube(video)
      %{
<p class="video">
  <object width="800" height="630"><param name="movie" value="http://www.youtube.com/v/#{video}&amp;hl=en&amp;fs=1&amp;rel=0&amp;color1=0x3a3a3a&amp;color2=0x999999"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/#{video}&amp;hl=en&amp;fs=1&amp;rel=0&amp;color1=0x3a3a3a&amp;color2=0x999999" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="800" height="630"></embed></object>
</p>
      }
    end

    private

    def _highlight(text, lexer)
      time 'pymentizing ' + lexer do
        result = Pygments.highlight text, lexer: lexer, options: { encoding: 'utf-8' }
        raise "Highlighting failed for lexer #{lexer}" if text.blank?
        result
      end
    end
  end
end