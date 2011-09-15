---
layout: post
title: "Tip: Automatic bundle exec for rake and other gems"
tags: [zsh, ruby, gem, rake, bundler, tip]
similar: [git]
---
It's irritating to run gem commands like `rake`, `cap`, `rspec` and others, only to find they needed to be executed via `bundle exec`.  As a simple solution, I use a simple zsh function, combined with aliases for commonly used commands.

Here's the function (which I've named `be`):

{% highlight text %}
if [[ -a Gemfile ]]; then
  bundle exec $*
else
  command $*
fi
{% endhighlight %}

It's very simple.  If there's a `Gemfile` in the pwd, it runs commands through bundle exec.  Otherwise it just runs them.

I've combined this with some aliases for much less pain and less frustration:

{% highlight text %}
alias rake='be rake'
alias cap='be cap'
alias rspec='be rspec'
{% endhighlight %}

