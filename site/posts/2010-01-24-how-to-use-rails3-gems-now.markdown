---
layout: post
title: "How to easily use Rails 3 now"
tags: [ruby, rails-3, gems]
---
Now that rails 3 is getting closer to release, I wanted to start playing around with it.  I've seen a few articles on getting it up and running, but they all seemed a little bit complicated.  To use rails 2.3.5 before its release, I just built the gems myself and installed them.  It turns out you can easily do the same with rails 3.

First, install rails main dependencies:

{% highlight bash %}
gem install rake rack bundler
gem install arel --version 0.2.pre
{% endhighlight %}

Next, get the latest rails code from github, and install the rails gems.  There may be a few errors you can safely ignore:

{% highlight bash %}
git clone git://github.com/rails/rails.git
cd rails
rake install
{% endhighlight %}

And bang, you can start your first rails 3 project:

{% highlight bash %}
rails ~/apps/playground/rails3 
{% endhighlight %}

Your existing projects shouldn't be affected as rails is installed as a prerelease gem, but to be safe I'd recommend a tool like [rvm](http://rvm.beginrescueend.com/) to switch to a clean set of gems.