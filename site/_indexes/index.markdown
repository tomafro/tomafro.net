---
layout: default
title: "Tom Ward's blog"
description: "Personal blog of Tom Ward, in which he writes about ruby, rails and web development, as well as other random ephemera"
---
{% for post in site.posts limit:5 %}
{% include 'post' with post %}
{% endfor %}
<div class="related">
<h3>More Posts</h3>
<p>{% for post in site.posts offset:5 %}<a href="{{ post.url }}">{{ post.title }}</a>{% unless forloop.last %} &middot; {% endunless %}{% endfor %}</p>
</div>