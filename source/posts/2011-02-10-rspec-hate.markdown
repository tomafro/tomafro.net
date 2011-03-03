---
layout: post
title: Rails 3 direct column readerasdasd
tags: [ruby, rails, rails3, active-record, column-reader]
draft: true
---
@hlame

Before I used it I disliked anecdotes about it breaking with every upgrade. I also disliked the syntax...

... Now that I have used it, I still find I dislike the syntax, but the stability is a non-issue. I think it's purely subjective.

I do like the emphasis the rspec community puts on rich matchers and good error messages though. We could all use that I think.

Finally, I'm not sure about the newer syntax either. What does let :something { .... } give me beyond direct assignment?

@beng 

I feared that RSpec made the sophistication of testing tools a virtue. I think it's got better. Prefer thinner harnesses myself.

not explained that well. The simpler the framework, the more pressure it puts on readability and elegance in the code under test.

@tomstuart

I like RSpec :(

The only times I hate it are when I upgrade to a newer version and something mysteriously breaks, but it's usually worth fixing.

Yeah. To me it seems to boil down to a disagreement over how much magic is too much (cf. Cucumber) but I expect there's more to it.

@nzkoz

http://twitter.com/#!/nzkoz/status/34887088633688064
I prefer classes and methods to weird blocks which emulate them. And assert_* to blah.should some_magic(thing)

http://twitter.com/#!/nzkoz/status/34888726408593408
By using non classes you lose all your other ruby tools. Inheritance, refactoring, etc. Don't get enough back

http://twitter.com/#!/nzkoz/status/34889586282856448
the impl is also crazy complex but I think that's driven by requirements, it's not excessive

http://twitter.com/#!/nzkoz/status/34890443166580737
extracting custom assertions, subclassing and modules to share common assertions/setup. And yeah, I do it a lot